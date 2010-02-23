﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;

namespace Mumble.Timerou.Models.Managers
{
    /// <summary>
    /// Provide methods to manage map interface
    /// </summary>
    public class MapManager
    {
        private TimerouContainer _container = null;

        public MapManager(TimerouContainer container)
        {
            _container = container;
        }

        /// <summary>
        /// Load pictures in specified bounds starting from offset. If no year is specified, gets pictures of all year
        /// </summary>
        /// <param name="bounds"></param>
        /// <param name="offset"></param>
        /// <returns></returns>
        public IEnumerable<Picture> LoadPictures(MapBounds bounds, int? year, int? page, int? pageSize, out int totalCount)
        {
            int limit = Int32.Parse(ConfigurationManager.AppSettings["PicturesLimit"]);
            var crossMeridian = bounds.CrossMeridian;

            IQueryable<Picture> pictures = (from p in _container.Media.Include("User").OfType<Picture>()
                                            where (year.HasValue && p.Year == year)
                                            && p.IsTemp == false
                                            && p.Lat >= bounds.SouthWest.Lat
                                            && p.Lat <= bounds.NorthEast.Lat
                                            && ((crossMeridian && (p.Lng >= bounds.SouthWest.Lng || p.Lng <= bounds.NorthEast.Lng))
                                               || (!crossMeridian && (p.Lng >= bounds.SouthWest.Lng && p.Lng <= bounds.NorthEast.Lng)))
                                            orderby p.Year, p.Views, p.Created descending
                                            select p);

            totalCount = pictures.Count();

            if (page.HasValue)
            {
                if (!pageSize.HasValue)
                {
                    throw new ArgumentException("pageSize");
                }

                int offset = (page.Value - 1) * pageSize.Value;
                pictures = pictures.Skip(offset).Take(pageSize.Value);
            }
            else
            {
                pictures = pictures.Take(limit);
            }

            return pictures;
        }

        /// <summary>
        /// Loaded pictures located inside specified bounds in specified year period, grouped by year
        /// </summary>
        /// <param name="bounds"></param>
        /// <param name="startYear"></param>
        /// <param name="stopYear"></param>
        /// <returns></returns>
        public IEnumerable<YearGroupedPictures> LoadOnePicturePerYear(MapBounds bounds, int startYear, int stopYear)
        {
            int picturesPerYear = Int32.Parse(ConfigurationManager.AppSettings["PicturesPerYear"]);
            var crossMeridian = bounds.CrossMeridian;

            var yearGroupedPicturesList = (from p in _container.Media.Include("User").OfType<Picture>()
                                           where startYear <= p.Year
                                           && stopYear >= p.Year
                                           && p.IsTemp == false
                                           && p.Lat >= bounds.SouthWest.Lat
                                           && p.Lat <= bounds.NorthEast.Lat
                                           && ((crossMeridian && (p.Lng >= bounds.SouthWest.Lng || p.Lng <= bounds.NorthEast.Lng))
                                              || (!crossMeridian && (p.Lng >= bounds.SouthWest.Lng && p.Lng <= bounds.NorthEast.Lng)))
                                           orderby p.Year, p.Views, p.Created descending
                                           group p by p.Year
                                               into yearGroup
                                               select new YearGroupedPictures()
                                               {
                                                   Year = yearGroup.Key,
                                                   Pictures = yearGroup.Take(picturesPerYear)
                                               }).ToList(); //this is needed because include is not supported in sub queries and another query is required in pictures to get paths.

            return yearGroupedPicturesList;
        }

        /// <summary>
        /// Load related pictures. A related picture is a picture near origin
        /// </summary>
        /// <param name="source"></param>
        /// <returns></returns>
        public IEnumerable<Picture> LoadRelatedPictures(MapBounds mapViewBounds, Picture picture)
        {
            double size = mapViewBounds.Width / 7.0;
            MapBounds searchBounds = MapBounds.CreateFromPoint(new LatLng(picture.Lat, picture.Lng), size);

            int limit = Int32.Parse(ConfigurationManager.AppSettings["PicturesLimit"]);
            var crossMeridian = searchBounds.CrossMeridian;

            var pictures = (from p in _container.Media.OfType<Picture>()
                            where p.Lat >= searchBounds.SouthWest.Lat
                            && p.Lat <= searchBounds.NorthEast.Lat
                            && p.IsTemp == false
                            && ((crossMeridian && (p.Lng >= searchBounds.SouthWest.Lng || p.Lng <= searchBounds.NorthEast.Lng))
                               || (!crossMeridian && (p.Lng >= searchBounds.SouthWest.Lng && p.Lng <= searchBounds.NorthEast.Lng)))
                            orderby p.Year, p.Views, p.Created descending
                            select p).Take(limit);

            return pictures;
        }
    }
}

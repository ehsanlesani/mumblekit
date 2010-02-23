using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;

namespace Mumble.Timerou.Models.Managers
{
    /// <summary>
    /// Provide methods to manage map interface
    /// </summary>
    public class MediaLoader
    {
        private TimerouContainer _container = null;

        public MediaLoader(TimerouContainer container)
        {
            _container = container;
        }

        /// <summary>
        /// Load media in specified bounds starting from offset. If no year is specified, gets pictures of all year
        /// </summary>
        /// <param name="bounds"></param>
        /// <param name="offset"></param>
        /// <returns></returns>
        public IEnumerable<Media> LoadMedia(MapBounds bounds, int? year, int? page, int? pageSize, out int totalCount)
        {
            int limit = Int32.Parse(ConfigurationManager.AppSettings["MediaLimit"]);
            var crossMeridian = bounds.CrossMeridian;

            IQueryable<Media> media = (from m in _container.Media.Include("User")
                                            where (year.HasValue && m.Year == year)
                                            && m.IsTemp == false
                                            && m.Lat >= bounds.SouthWest.Lat
                                            && m.Lat <= bounds.NorthEast.Lat
                                            && ((crossMeridian && (m.Lng >= bounds.SouthWest.Lng || m.Lng <= bounds.NorthEast.Lng))
                                               || (!crossMeridian && (m.Lng >= bounds.SouthWest.Lng && m.Lng <= bounds.NorthEast.Lng)))
                                            orderby m.Year, m.Views, m.Created descending
                                            select m);

            totalCount = media.Count();

            if (page.HasValue)
            {
                if (!pageSize.HasValue)
                {
                    throw new ArgumentException("pageSize");
                }

                int offset = (page.Value - 1) * pageSize.Value;
                media = media.Skip(offset).Take(pageSize.Value);
            }
            else
            {
                media = media.Take(limit);
            }

            return media;
        }

        /// <summary>
        /// Loaded media located inside specified bounds in specified year period, grouped by year
        /// </summary>
        /// <param name="bounds"></param>
        /// <param name="startYear"></param>
        /// <param name="stopYear"></param>
        /// <returns></returns>
        public IEnumerable<YearGroupedMedias> LoadOneMediaPerYear(MapBounds bounds, int startYear, int stopYear)
        {
            int mediaPerYear = Int32.Parse(ConfigurationManager.AppSettings["MediaPerYear"]);
            var crossMeridian = bounds.CrossMeridian;

            var yearGroupedMediaList = (from m in _container.Media.Include("User")
                                           where startYear <= m.Year
                                           && m.IsTemp == false
                                           && stopYear >= m.Year
                                           && m.Lat >= bounds.SouthWest.Lat
                                           && m.Lat <= bounds.NorthEast.Lat
                                           && ((crossMeridian && (m.Lng >= bounds.SouthWest.Lng || m.Lng <= bounds.NorthEast.Lng))
                                              || (!crossMeridian && (m.Lng >= bounds.SouthWest.Lng && m.Lng <= bounds.NorthEast.Lng)))
                                           orderby m.Year, m.Views, m.Created descending
                                           group m by m.Year
                                               into yearGroup
                                               select new YearGroupedMedias()
                                               {
                                                   Year = yearGroup.Key,
                                                   Medias = yearGroup.Take(mediaPerYear)
                                               }).ToList(); //this is needed because include is not supported in sub queries and another query is required in pictures to get paths.

            return yearGroupedMediaList;
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

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

            IQueryable<Picture> pictures = (from p in _container.MapObjects.Include("User").OfType<Picture>()
                            where (year.HasValue && p.Year == year)
                            && p.Lat <= bounds.TopLeft.Lat
                            && p.Lat >= bounds.BottomRight.Lat
                            && ((crossMeridian && (p.Lng >= bounds.TopLeft.Lng || p.Lng <= bounds.BottomRight.Lng))
                               || (!crossMeridian && (p.Lng >= bounds.TopLeft.Lng && p.Lng <= bounds.BottomRight.Lng)))
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

            var pictures = (from p in _container.MapObjects.OfType<Picture>()
                            where p.Lat <= searchBounds.TopLeft.Lat
                            && p.Lat >= searchBounds.BottomRight.Lat
                            && ((crossMeridian && (p.Lng >= searchBounds.TopLeft.Lng || p.Lng <= searchBounds.BottomRight.Lng))
                               || (!crossMeridian && (p.Lng >= searchBounds.TopLeft.Lng && p.Lng <= searchBounds.BottomRight.Lng)))
                            orderby p.Year, p.Views, p.Created descending
                            select p).Take(limit);

            return pictures;
        }
    }
}

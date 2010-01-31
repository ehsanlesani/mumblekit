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
        /// Load pictures in specified bounds starting from offset
        /// </summary>
        /// <param name="bounds"></param>
        /// <param name="offset"></param>
        /// <returns></returns>
        public IEnumerable<Picture> LoadPictures(MapBounds bounds, int year)
        {
            int limit = Int32.Parse(ConfigurationManager.AppSettings["PicturesLimit"]);
            var crossMeridian = bounds.TopLeft.Lng > bounds.BottomRight.Lng;

            var pictures = (from p in _container.MapObjects.Include("User").OfType<Picture>()
                            where p.Year == year
                            && p.Lat <= bounds.TopLeft.Lat
                            && p.Lat >= bounds.BottomRight.Lat
                            && ((crossMeridian && (p.Lng >= bounds.TopLeft.Lng || p.Lng <= bounds.BottomRight.Lng))
                               || (!crossMeridian && (p.Lng >= bounds.TopLeft.Lng && p.Lng <= bounds.BottomRight.Lng)))
                            orderby p.Views, p.Created descending
                            select p).Take(limit);


            return pictures;
        }
    }
}

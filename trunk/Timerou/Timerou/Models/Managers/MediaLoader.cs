using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using Mumble.Timerou.Models.Exceptions;

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
        public IEnumerable<Media> LoadMedias(MapBounds bounds, int? year, int? page, int? pageSize, out int totalCount)
        {
            int limit = Int32.Parse(ConfigurationManager.AppSettings["MediaLimit"]);
            var crossMeridian = bounds.CrossMeridian;

            IQueryable<Media> medias = (from m in _container.Medias.Include("User")
                                            where (year.HasValue && m.Year == year)
                                            && m.IsTemp == false
                                            && m.Lat >= bounds.SouthWest.Lat
                                            && m.Lat <= bounds.NorthEast.Lat
                                            && ((crossMeridian && (m.Lng >= bounds.SouthWest.Lng || m.Lng <= bounds.NorthEast.Lng))
                                               || (!crossMeridian && (m.Lng >= bounds.SouthWest.Lng && m.Lng <= bounds.NorthEast.Lng)))
                                            orderby m.Year, m.Views, m.Created descending
                                            select m);

            totalCount = medias.Count();

            if (page.HasValue)
            {
                if (!pageSize.HasValue)
                {
                    throw new ArgumentException("pageSize");
                }

                int offset = (page.Value - 1) * pageSize.Value;
                medias = medias.Skip(offset).Take(pageSize.Value);
            }
            else
            {
                medias = medias.Take(limit);
            }

            return medias;
        }

        /// <summary>
        /// Search and load user medias ordered by creation date
        /// </summary>
        /// <param name="bounds"></param>
        /// <param name="offset"></param>
        /// <returns></returns>
        public IEnumerable<Media> LoadUserMedias(User user, string keyword, int? year, int? page, int? pageSize, out int totalCount)
        {
            if (user == null)
            {
                throw new ArgumentNullException("user");
            }

            int limit = Int32.Parse(ConfigurationManager.AppSettings["MediaLimit"]);

            IQueryable<Media> medias = _container.Medias.Where(m => (m.User.Id == user.Id) && (!(bool)m.IsTemp));

            if (!String.IsNullOrEmpty(keyword))
            {
                medias = medias.Where(m => m.Title.Contains(keyword));
            }

            if (year.HasValue)
            {
                medias = medias.Where(m => m.Year == year.Value);
            }

            totalCount = medias.Count();

            medias = medias.OrderByDescending(m => m.Created);

            if (page.HasValue)
            {
                if (!pageSize.HasValue)
                {
                    throw new ArgumentException("pageSize");
                }

                int offset = (page.Value - 1) * pageSize.Value;
                medias = medias.Skip(offset).Take(pageSize.Value);
            }
            else
            {
                medias = medias.Take(limit);
            }

            return medias;
        }

        /// <summary>
        /// Loaded media located inside specified bounds from last year going back until slots are full, grouped by year
        /// </summary>
        public List<YearGroupedMedias> LoadOneMediaPerYear(MapBounds bounds, int mediasToLoad, int referenceYear, SearchDirection direction, out int minYearDistance)
        {
            int mediaPerYear = Int32.Parse(ConfigurationManager.AppSettings["MediaPerYear"]);
            var crossMeridian = bounds.CrossMeridian;

            var yearGroupedMedias = (from m in _container.Medias.Include("User")
                                     where m.IsTemp == false
                                     && m.Lat >= bounds.SouthWest.Lat
                                     && m.Lat <= bounds.NorthEast.Lat
                                     && ((crossMeridian && (m.Lng >= bounds.SouthWest.Lng || m.Lng <= bounds.NorthEast.Lng))
                                        || (!crossMeridian && (m.Lng >= bounds.SouthWest.Lng && m.Lng <= bounds.NorthEast.Lng)))
                                     orderby m.Year, m.Views, m.Created
                                     group m by m.Year
                                         into yearGroup
                                         orderby yearGroup.Key descending
                                         select new YearGroupedMedias()
                                         {
                                             Year = yearGroup.Key,
                                             Medias = yearGroup.OrderByDescending(m => m.Views).ThenByDescending(m=> m.Created).Take(mediaPerYear)
                                         }); //toList is needed because include is not supported in sub queries and another query is required in pictures to get paths.

            switch (direction)
            {
                case SearchDirection.Back:
                    yearGroupedMedias = yearGroupedMedias
                        .Where(m => m.Year <= referenceYear)
                        .OrderByDescending(m => m.Year)
                        .Take(mediasToLoad);
                    break;
                case SearchDirection.Forward:
                    yearGroupedMedias = yearGroupedMedias
                        .Where(m => m.Year >= referenceYear)
                        .OrderByDescending(m => m.Year)
                        .Take(mediasToLoad);
                    break;
            }

            int totalCount = yearGroupedMedias.Count();
            minYearDistance = DateTime.Now.Year; //represents minimum year step

            //check viewables media
            if (totalCount > 0)
            {
                //find min year distance between medias

                var lastMediaGroup = yearGroupedMedias.First();
                foreach (var mediaGroup in yearGroupedMedias)
                {
                    if (mediaGroup.Year == lastMediaGroup.Year) { continue; } //skip first element
                    minYearDistance = Math.Min(minYearDistance, Math.Abs(lastMediaGroup.Year - mediaGroup.Year));
                    lastMediaGroup = mediaGroup;
                }

                /* calculate minimun viewable year for medias, controlling minimum year distance and number of view slots in timebar
                 * es: medias[] = { 2010, 2008, 2005, 1920 }, slots = 5, minYearDistance = 2010 - 2008 = 2, minYearThatCanBe = 2010 - (5 * 2) = 2000
                 * 1920 is invisible on the bar because is too far and is not possible display distance effect in timebar */

                if (direction == SearchDirection.Back)
                {
                    int maxYear = yearGroupedMedias.Select(m => m.Year).Max();
                    int minYearThatCanBe = maxYear - (minYearDistance * mediasToLoad);
                    //filter medias
                    yearGroupedMedias = yearGroupedMedias.Where(m => m.Year >= minYearThatCanBe);
                }
                else if (direction == SearchDirection.Forward)
                {
                    int minYear = yearGroupedMedias.Select(m => m.Year).Min();
                    int maxYearThatCanBe = minYear + (minYearDistance * mediasToLoad);
                    //filter medias
                    yearGroupedMedias = yearGroupedMedias.Where(m => m.Year <= maxYearThatCanBe);
                }
            }

            return yearGroupedMedias.ToList();
        }

        /// <summary>
        /// Return number of medias before specified year
        /// </summary>
        public int CountMediasBeforeYear(MapBounds bounds, int year)
        {
            int limit = Int32.Parse(ConfigurationManager.AppSettings["MediaLimit"]);
            var crossMeridian = bounds.CrossMeridian;

            var count = (from m in _container.Medias
                                        where (m.Year < year)
                                        && m.IsTemp == false
                                        && m.Lat >= bounds.SouthWest.Lat
                                        && m.Lat <= bounds.NorthEast.Lat
                                        && ((crossMeridian && (m.Lng >= bounds.SouthWest.Lng || m.Lng <= bounds.NorthEast.Lng))
                                           || (!crossMeridian && (m.Lng >= bounds.SouthWest.Lng && m.Lng <= bounds.NorthEast.Lng)))
                                        select m).Count();

            return count;
        }

        /// <summary>
        /// Return number of medias after specified year
        /// </summary>
        public int CountMediasAfterYear(MapBounds bounds, int year)
        {
            int limit = Int32.Parse(ConfigurationManager.AppSettings["MediaLimit"]);
            var crossMeridian = bounds.CrossMeridian;

            var count = (from m in _container.Medias
                         where (m.Year > year)
                         && m.IsTemp == false
                         && m.Lat >= bounds.SouthWest.Lat
                         && m.Lat <= bounds.NorthEast.Lat
                         && ((crossMeridian && (m.Lng >= bounds.SouthWest.Lng || m.Lng <= bounds.NorthEast.Lng))
                            || (!crossMeridian && (m.Lng >= bounds.SouthWest.Lng && m.Lng <= bounds.NorthEast.Lng)))
                         select m).Count();

            return count;
        }

        /// <summary>
        /// Load related pictures. A related picture is a picture near origin
        /// </summary>
        public IEnumerable<Picture> LoadRelatedPictures(MapBounds mapViewBounds, Picture picture)
        {
            double size = mapViewBounds.Width / 7.0;
            MapBounds searchBounds = MapBounds.CreateFromPoint(new LatLng(picture.Lat, picture.Lng), size);

            int limit = Int32.Parse(ConfigurationManager.AppSettings["PicturesLimit"]);
            var crossMeridian = searchBounds.CrossMeridian;

            var pictures = (from p in _container.Medias.OfType<Picture>()
                            where p.Lat >= searchBounds.SouthWest.Lat
                            && p.Lat <= searchBounds.NorthEast.Lat
                            && p.IsTemp == false
                            && ((crossMeridian && (p.Lng >= searchBounds.SouthWest.Lng || p.Lng <= searchBounds.NorthEast.Lng))
                               || (!crossMeridian && (p.Lng >= searchBounds.SouthWest.Lng && p.Lng <= searchBounds.NorthEast.Lng)))
                            orderby p.Year, p.Views, p.Created descending
                            select p).Take(limit);

            return pictures;
        }

        /// <summary>
        /// Load single media by id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public Media LoadMedia(Guid id)
        {
            Media media = _container.Medias.Where(m => m.Id == id).FirstOrDefault();
            if (media == null)
            {
                throw new MediaNotFoundException(id);
            }

            return media;
        }
    }
}

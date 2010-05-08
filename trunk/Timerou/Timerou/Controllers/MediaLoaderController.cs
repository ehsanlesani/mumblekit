using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using Mumble.Timerou.Models.Auth;
using Mumble.Timerou.Models.Managers;
using Mumble.Timerou.Models;
using Mumble.Timerou.Models.Responses;
using Mumble.Timerou.Models.Exceptions;

namespace Mumble.Timerou.Controllers
{
    public class MediaLoaderController : AuthController
    {
        /// <summary>
        /// Gets pictures in specified bounds. This is an ajax call
        /// </summary>
        public ActionResult LoadMedias(double? swlat, double? swlng, double? nelat, double? nelng, int year, int page, int pageSize)
        {
            try
            {
                MediaLoader mediaLoader = new MediaLoader(Container);

                int totalCount = 0;
                MapBounds mapBounds = new MapBounds(new LatLng(swlat.Value, swlng.Value), new LatLng(nelat.Value, nelng.Value));
                IEnumerable<Media> media = mediaLoader.LoadMedias(mapBounds, year, page, pageSize, out totalCount);
                LoadMediasResponse response = LoadMediasResponse.FromList(media);
                response.TotalCount = totalCount;

                return this.CamelCaseJson(response);
            }
            catch (Exception ex)
            {
                return this.CamelCaseJson(new SimpleResponse(true, ex.Message));
            }
        }

        /// <summary>
        /// Load one media per year in specified years range
        /// </summary>
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult LoadOneMediaPerYear(double? swlat, double? swlng, double? nelat, double? nelng, int mediasToLoad, int referenceYear, SearchDirection direction)
        {
            try
            {
                MapBounds mapBounds = new MapBounds(new LatLng(swlat.Value, swlng.Value), new LatLng(nelat.Value, nelng.Value));
                MediaLoader mediaLoader = new MediaLoader(Container);
                int minYearDistance = 0;
                IEnumerable<YearGroupedMedias> groupedMedia = mediaLoader.LoadOneMediaPerYear(mapBounds, mediasToLoad, referenceYear, direction, out minYearDistance);
                YearGroupedMediasResponse response = YearGroupedMediasResponse.FromList(groupedMedia, true);
                if (response.GroupedMedias.Count > 0)
                {
                    response.HasMediasAfter = mediaLoader.CountMediasAfterYear(mapBounds, response.MaxYear) > 0;
                    response.HasMediasBefore = mediaLoader.CountMediasBeforeYear(mapBounds, response.MinYear) > 0;
                    response.MinYearDistance = minYearDistance;
                }

                return this.CamelCaseJson(response);
            }
            catch (Exception ex)
            {
                return this.CamelCaseJson(new SimpleResponse(true, ex.Message));
            }
        }

        /// <summary>
        /// Load single media by id
        /// </summary>
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult LoadMedia(Guid id)
        {
            try
            {
                MediaLoader mediaLoader = new MediaLoader(Container);
                Media media = mediaLoader.LoadMedia(id);
                LoadMediaResponse response = LoadMediaResponse.FromMedia(media);

                return this.CamelCaseJson(response);
            }
            catch (MediaNotFoundException ex)
            {
                return this.CamelCaseJson(new SimpleResponse(true, String.Format("Media with id {0} not found", ex.MediaId)));
            }
            catch (Exception ex)
            {
                return this.CamelCaseJson(new SimpleResponse(true, ex.Message));
            }
        }

        /// <summary>
        /// Load single media by id
        /// </summary>
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult LoadCities(double? swlat, double? swlng, double? nelat, double? nelng, int year)
        {
            try
            {
                MediaLoader mediaLoader = new MediaLoader(Container);
                MapBounds mapBounds = new MapBounds(new LatLng(swlat.Value, swlng.Value), new LatLng(nelat.Value, nelng.Value));
                IEnumerable<GeoInfo> info = mediaLoader.LoadCities(mapBounds, year);
                LoadCitiesResponse response = LoadCitiesResponse.FromList(info);

                return this.CamelCaseJson(response);
            }
            catch (MediaNotFoundException ex)
            {
                return this.CamelCaseJson(new SimpleResponse(true, String.Format("Media with id {0} not found", ex.MediaId)));
            }
            catch (Exception ex)
            {
                return this.CamelCaseJson(new SimpleResponse(true, ex.Message));
            }
        }
    }
}

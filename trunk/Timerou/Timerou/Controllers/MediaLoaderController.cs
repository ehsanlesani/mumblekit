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
                MediaLoader mapManager = new MediaLoader(Container);

                int totalCount = 0;
                MapBounds mapBounds = new MapBounds(new LatLng(swlat.Value, swlng.Value), new LatLng(nelat.Value, nelng.Value));
                IEnumerable<Media> media = mapManager.LoadMedia(mapBounds, year, page, pageSize, out totalCount);
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
        public ActionResult LoadOneMediaPerYear(double? swlat, double? swlng, double? nelat, double? nelng, int? startYear, int? stopYear)
        {
            try
            {
                MapBounds mapBounds = new MapBounds(new LatLng(swlat.Value, swlng.Value), new LatLng(nelat.Value, nelng.Value));
                MediaLoader mapManager = new MediaLoader(Container);
                IEnumerable<YearGroupedMedias> groupedMedia = mapManager.LoadOneMediaPerYear(mapBounds, startYear.Value, stopYear.Value);
                YearGroupedMediasResponse response = YearGroupedMediasResponse.FromList(groupedMedia);

                return this.CamelCaseJson(response);
            }
            catch (Exception ex)
            {
                return this.CamelCaseJson(new SimpleResponse(true, ex.Message));
            }
        }

    }
}

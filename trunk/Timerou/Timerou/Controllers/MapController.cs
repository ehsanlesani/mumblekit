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
    public class MapController : AuthController
    {
        /// <summary>
        /// Gets pictures in specified bounds. This is an ajax call
        /// </summary>
        public ActionResult LoadPictures(double? swlat, double? swlng, double? nelat, double? nelng, int year, int page, int pageSize)
        {
            try
            {
                MapManager mapManager = new MapManager(Container);

                int totalCount = 0;
                MapBounds mapBounds = new MapBounds(new LatLng(swlat.Value, swlng.Value), new LatLng(nelat.Value, nelng.Value));
                IEnumerable<Picture> pictures = mapManager.LoadPictures(mapBounds, year, page, pageSize, out totalCount);
                LoadPicturesResponse response = LoadPicturesResponse.FromList(pictures);
                response.TotalCount = totalCount;

                return this.CamelCaseJson(response);
            }
            catch (Exception ex)
            {
                return this.CamelCaseJson(new SimpleResponse(true, ex.Message));
            }
        }

        /// <summary>
        /// Load one pictures per year in specified years range
        /// </summary>
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult LoadOnePicturePerYear(double? swlat, double? swlng, double? nelat, double? nelng, int? startYear, int? stopYear)
        {
            try
            {
                MapBounds mapBounds = new MapBounds(new LatLng(swlat.Value, swlng.Value), new LatLng(nelat.Value, nelng.Value));
                MapManager mapManager = new MapManager(Container);
                IEnumerable<YearGroupedPictures> groupedPictures = mapManager.LoadOnePicturePerYear(mapBounds, startYear.Value, stopYear.Value);
                YearGroupedPicturesResponse response = YearGroupedPicturesResponse.FromList(groupedPictures);

                return this.CamelCaseJson(response);
            }
            catch (Exception ex)
            {
                return this.CamelCaseJson(new SimpleResponse(true, ex.Message));
            }
        }

    }
}

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
        /// <param name="lat1"></param>
        /// <param name="lng1"></param>
        /// <param name="lat2"></param>
        /// <param name="lng2"></param>
        /// <param name="startOffset"></param>
        /// <returns></returns>
        public ActionResult LoadPictures(double lat1, double lng1, double lat2, double lng2, int year)
        {
            try
            {
                MapManager mapManager = new MapManager(Container);
                IEnumerable<Picture> pictures = mapManager.LoadPictures(new MapBounds(new LatLng(lat1, lng1), new LatLng(lat2, lng2)), year);
                LoadPicturesResponse response = LoadPicturesResponse.FromList(pictures);

                return this.CamelCaseJson(response);
            }
            catch (Exception ex)
            {
                return this.CamelCaseJson(new SimpleResponse(true, ex.Message));
            }
        }

        /// <summary>
        /// Get related pictures. A related picture is a picture near specified
        /// </summary>
        /// <param name="pictureId"></param>
        /// <param name="lat1"></param>
        /// <param name="lng1"></param>
        /// <param name="lat2"></param>
        /// <param name="lng2"></param>
        /// <returns></returns>
        public ActionResult LoadRelatedPictures(Guid pictureId, double lat1, double lng1, double lat2, double lng2)
        {
            try
            {
                MapBounds mapViewBounds = new MapBounds(new LatLng(lat1, lng1), new LatLng(lat2, lng2));
                Picture picture = Container.MapObjects.OfType<Picture>().Where(p => p.Id == pictureId).First();

                MapManager mapManager = new MapManager(Container);
                IEnumerable<Picture> pictures = mapManager.LoadRelatedPictures(mapViewBounds, picture);
                LoadPicturesResponse response = LoadPicturesResponse.FromList(pictures);

                return this.CamelCaseJson(response);
            }
            catch (Exception ex)
            {
                return this.CamelCaseJson(new SimpleResponse(true, ex.Message));
            }
        }

    }
}

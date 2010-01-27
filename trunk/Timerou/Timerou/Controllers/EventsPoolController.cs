using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using Mumble.Timerou.Models.Auth;
using Mumble.Timerou.Models.Exceptions;
using Mumble.Timerou.Models.Responses;
using Mumble.Timerou.Models.Helpers;

namespace Mumble.Timerou.Controllers
{
    public class EventsPoolController : AuthController
    {
        public EventsPoolController()
        {

        }

        /// <summary>
        /// Check if a server event is raised
        /// </summary>
        /// <returns></returns>
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Check()
        {
            try
            {
                Authorize();

                
            }
            catch (AuthException)
            {
                return Json(new SimpleResponse(true, UIHelper.Translate("err.unauthorized")));
            }

            return Json(new SimpleResponse(true, UIHelper.Translate("err.unauthorized")));
        }

    }
}

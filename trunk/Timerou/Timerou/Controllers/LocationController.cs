using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using System.Configuration;

namespace Mumble.Timerou.Controllers
{
    public class LocationController : Controller
    {
        //
        // GET: /Location/

        public ActionResult Index(string bounds, int? year, double? r)
        {
            ViewData["Bounds"] = bounds;
            ViewData["Year"] = year.HasValue ? year.Value : DateTime.Now.Year;
            
            return View();
        }

    }
}

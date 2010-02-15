using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;

namespace Mumble.Timerou.Controllers
{
    public class ErrorController : Controller
    {
        //
        // GET: /Error/

        public ActionResult Index()
        {
            ViewData["Error"] = HttpContext.Application["LastError"];
            HttpContext.Application.Remove("LastError");
            
            return View();
        }

    }
}

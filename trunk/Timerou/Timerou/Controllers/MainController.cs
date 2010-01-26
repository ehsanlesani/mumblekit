using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Mumble.Timerou.Models;
using Mumble.Timerou.Models.Helpers;
using System.IO;

namespace Mumble.Timerou.Controllers
{
    [HandleError]
    public class MainController : Controller
    {
        private TimerouContainer _container = new TimerouContainer();

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult About()
        {
            return View();
        }
    }
}

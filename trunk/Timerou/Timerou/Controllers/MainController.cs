using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Mumble.Timerou.Models;
using Mumble.Timerou.Models.Helpers;
using System.IO;
using Mumble.Timerou.Models.Auth;
using Mumble.Timerou.Models.Exceptions;

namespace Mumble.Timerou.Controllers
{
    [HandleError]
    public class MainController : AuthController
    {
        private TimerouContainer _container = new TimerouContainer();

        public ActionResult Index()
        {
            try
            {
                Authorize();
            }
            catch (AuthException)
            {
                return RedirectToAction("Login", "Account", new { redirectUrl = Url.Action("Index", "Main") });
            }
            
            return View();
        }

        public ActionResult About()
        {
            return View();
        }
    }
}

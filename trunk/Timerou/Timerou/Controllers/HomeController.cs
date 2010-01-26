using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using Mumble.Timerou.Models.Auth;
using Mumble.Timerou.Models.Exceptions;
using Mumble.Timerou.Models.Helpers;
using Mumble.Timerou.Models;
using Mumble.Timerou.Models.Responses;

namespace Mumble.Timerou.Controllers
{
    public class HomeController : AuthController
    {
        public ActionResult Index()
        {
            try
            {
                Authorize();
            }
            catch (AuthException)
            {
                 return RedirectToAction("Login", "Account", new { redirectUrl = Url.Action("Index", "Home") });
            }

            return View();
        }

        
    }
}

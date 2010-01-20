using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using Mumble.Friendsheep.Models.Auth;
using Mumble.Friendsheep.Models.Exceptions;
using Mumble.Friendsheep.Models.Helpers;
using Mumble.Friendsheep.Models;
using Mumble.Friendsheep.Models.Responses;

namespace Mumble.Friendsheep.Controllers
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

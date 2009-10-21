using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using Mumble.Web.StarterKit.Models;

namespace Mumble.Web.StarterKit.Controllers.Admin
{
    public class LoginController : Controller
    {
        //
        // GET: /Home/

        public ActionResult Index()
        {
            var user = Security.Instance.GetLoggedUser();
            ViewData["User"] = user;
            
            return View("Index");
        }

        public ActionResult Login(string email, string password)
        {
            Security.Instance.Login(email, password);

            return Index();
        }
    }
}

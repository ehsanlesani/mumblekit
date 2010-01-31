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
                
                /*Random rnd = new Random(Environment.TickCount);

                for (var i = 0; i < 100; i++)
                {
                    for (var y = 0; y < 100; y++)
                    {
                        Picture picture = new Picture()
                        {
                            User = AccountManager.LoggedUser,
                            Id = Guid.NewGuid(),
                            Created = DateTime.Now.AddDays(rnd.Next(-100, 0)),
                            Title = String.Format("Picture {0}-{1}", i, y),
                            Lat = rnd.Next(-90, 90),
                            Lng = rnd.Next(-180, 180),
                            IsTemp = false,
                            Year = 2010
                        };

                        Container.AddToMapObjects(picture);                        
                    }

                    Container.SaveChanges();
                }*/
            }
            catch (AuthException)
            {
                 return RedirectToAction("Login", "Account", new { redirectUrl = Url.Action("Index", "Home") });
            }

            return View();
        }

        
    }
}

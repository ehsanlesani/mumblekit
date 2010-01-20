using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Mumble.Friendsheep.Models;
using Mumble.Friendsheep.Models.Helpers;
using System.IO;

namespace Friendsheep.Controllers
{
    [HandleError]
    public class MainController : Controller
    {
        private FriendsheepContainer _container = new FriendsheepContainer();

        public ActionResult Index()
        {
            var items = (from f in _container.Farms.AsEnumerable()
                         select new SelectListItem() { Text = f.Name, Value = f.Id.ToString() }).ToList();
            items.Insert(0, new SelectListItem() { Text = UIHelper.Translate("txt.select") + "...", Value = "" });
            ViewData["Farms"] = new SelectList(items, "Value", "Text");
            return View();
        }

        public ActionResult About()
        {
            return View();
        }
    }
}

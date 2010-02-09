using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using Mumble.Web.StarterKit.Models.ViewModels;
using Mumble.Web.StarterKit.Models.ExtPartial;
using Mumble.Web.StarterKit.Models.Common;

namespace Mumble.Web.StarterKit.Controllers.Site
{
    public class PageController : Controller
    {
        public ActionResult Index(string page)
        {
            ViewData["MenuTabs"] = MenuTab.GetMenuItems();
            ViewData["Footer"] = MenuTab.GetGlobalPages();

            return View();
        }
    }
}

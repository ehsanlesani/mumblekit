using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using Mumble.Web.StarterKit.Models;
using System.Collections;
using Mumble.Web.StarterKit.Models.Common;

namespace Mumble.Web.StarterKit.Controllers.Site
{
    public class HomeController : Controller
    {
        //
        // GET: /Home/

        public ActionResult Index()
        {
            try
            {
                ViewData["RegionItems"] = GetRegionsSelectList();
                ViewData["MenuTabs"] = MenuTab.GetMenuItems();
            }
            catch(Exception) 
            {
            }
            
            return View();            
        }
        
        private IList<SelectListItem> GetRegionsSelectList() 
        {
            StarterKitContainer context = new StarterKitContainer();
            var regions = (from r in context.Regions orderby r.Description select r);
            IList<SelectListItem> items = new List<SelectListItem>();
            foreach (Region r in regions) 
            {
                SelectListItem s = new SelectListItem();
                s.Text = r.Description;
                s.Value = r.Id.ToString();
                items.Add(s);
            }

            return items;
        }
    }
}

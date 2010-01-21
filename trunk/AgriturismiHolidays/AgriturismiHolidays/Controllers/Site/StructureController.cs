using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;

namespace Mumble.Web.StarterKit.Controllers.Site
{
    public class StructureController : Controller
    {
        //
        // GET: /Structure/

        public ActionResult Index()
        {
            return View();
        }

        public ActionResult List(string category) 
        {
            if(category != null)
                ViewData["SectionName"] = category.Replace("_", " ");

            return View();
        }
    }
}

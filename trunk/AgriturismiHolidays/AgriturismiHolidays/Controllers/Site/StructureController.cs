using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using Mumble.Web.StarterKit.Models.ViewModels;
using Mumble.Web.StarterKit.Models.ExtPartial;

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
            try
            {
                StarterKitContainer context = new StarterKitContainer();
                string cat = "";
                //Accommodation a = new Accommodation(); //a.Attachments.ElementAt<Attachment>(0).Path
                if (category != null)
                    cat = category.Replace("_", " ");

                var res = (from a in context.Accommodations where a.AccommodationType.Name == cat select a).AsEnumerable<Accommodation>();

                StructureListViewModel vm = new StructureListViewModel(res);
                vm.SectionName = cat;

                return View(vm);
            }
            catch(Exception) 
            {
                return View();
            }
        }
    }
}

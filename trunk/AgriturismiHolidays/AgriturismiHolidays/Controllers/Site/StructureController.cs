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
    public class StructureController : Controller
    {
        //
        // GET: /Structure/

        public ActionResult Index()
        {
            ViewData["MenuTabs"] = MenuTab.GetMenuItems();
            return View();
        }

        public ActionResult List(string category) 
        {
            StructureListViewModel vm = new StructureListViewModel();

            try
            {
                ViewData["MenuTabs"] = MenuTab.GetMenuItems();

                StarterKitContainer context = new StarterKitContainer();
                string cat = "";

                if (category != null)
                    if (category.Length > 0)
                        cat = category.Replace("_", " ");

                var res = (from a in context.Accommodations where a.AccommodationType.Name == cat select a).AsEnumerable<Accommodation>();

                vm.Accommodations = res;
                vm.SectionName = cat;

                return View(vm);
            }
            catch(Exception ex) 
            {
                vm.SetError(ex.Message);
                return View(vm);
            }
        }

        public ActionResult Show(string id)
        {
            StructureViewModel vm = new StructureViewModel();
            ViewData["MenuTabs"] = MenuTab.GetMenuItems();

            try
            {
                StarterKitContainer context = new StarterKitContainer();                
                Guid guid = new Guid(id);

                var acco = (from a in context.Accommodations where a.Id.Equals(guid) select a).FirstOrDefault<Accommodation>();

                vm.Accommodation = acco;

                return View(vm);
            }
            catch(Exception ex)
            {
                vm.SetError(ex.Message);
                return View(vm);
            }           
        }
    }
}

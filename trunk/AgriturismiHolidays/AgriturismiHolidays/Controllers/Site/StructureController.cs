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
        private int _itemsPerPage = 3;
        //
        // GET: /Structure/

        public ActionResult Index()
        {
            ViewData["MenuTabs"] = MenuTab.GetMenuItems();
            ViewData["Footer"] = MenuTab.GetGlobalPages();
            return View();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="category"></param>
        /// <param name="toSkip">Page Number</param>
        /// <returns></returns>
        public ActionResult List(string category, Guid? regionItems, int? toSkip) 
        {
            StructureListViewModel vm = new StructureListViewModel();

            try
            {
                ViewData["MenuTabs"] = MenuTab.GetMenuItems();
                ViewData["Footer"] = MenuTab.GetGlobalPages();

                StarterKitContainer context = new StarterKitContainer();
                string cat = "";
                

                if (category != null)
                    if (category.Length > 0)
                        cat = category.Replace("_", " ");

                var res = (from a in context.Accommodations
                           where (!regionItems.HasValue || a.Municipalities.Provinces.Region.Id == regionItems)
                           && a.AccommodationType.Name == cat orderby a.Name ascending
                           select a);

                //items to skip
                int itemsToSkip = (int)(toSkip.GetValueOrDefault() * _itemsPerPage);

                vm.Accommodations = res.Skip(itemsToSkip).Take(_itemsPerPage);
                vm.SectionName = cat;
                vm.Pages = (int) (Math.Ceiling((res.Count() / (double)_itemsPerPage)) - 1);
                vm.ActualPage = toSkip.GetValueOrDefault();
                vm.ItemsPerPage = _itemsPerPage;
                
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
            ViewData["Footer"] = MenuTab.GetGlobalPages();

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

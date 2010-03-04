using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using Mumble.Web.StarterKit.Models.ViewModels;
using Mumble.Web.StarterKit.Models.ExtPartial;
using Mumble.Web.StarterKit.Models.Common;
using Mumble.Web.StarterKit.Models.Auth;

namespace Mumble.Web.StarterKit.Controllers.Site
{
    public class StructureController : AuthController
    {
        StarterKitContainer _context = new StarterKitContainer();
        private int _itemsPerPage = 10;


        protected void Populate()
        {
            ViewData["MenuTabs"] = MenuTab.GetMenuItems();
            ViewData["Footer"] = MenuTab.GetGlobalPages();

            LoginModel loginModel = new LoginModel();
            loginModel.RedirectUrl = Url.Action("PersonalPage", "Account");
            ViewData["Login"] = loginModel;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            Populate();
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
                Populate();

                if (String.IsNullOrEmpty(category))
                    throw new Exception("categoria non selezionata");

                string cat = "";

                if (category != null)
                {
                    if (category.Length > 0)
                        cat = category.Replace("_", " ");
                }
                else
                    throw new Exception("nome categoria non valida");

                var res = (from a in _context.Accommodations
                           where (!regionItems.HasValue || a.Municipalities.Provinces.Region.Id == regionItems)
                           && a.AccommodationType.Name == cat orderby a.Name ascending
                           select a);

                int itemsToSkip = (int)(toSkip.GetValueOrDefault() * _itemsPerPage);

                vm.StaticPages = GetStaticPages(cat);
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

        /// <summary>
        /// 
        /// </summary>
        /// <param name="category">Replaced category name</param>
        /// <returns></returns>
        private IQueryable<Page> GetStaticPages(string category) 
        { 
            var pages = (from p in _context.Pages where 
                             p.Sections.Description == "side" && 
                             p.AccommodationTypes.Name == category && 
                             p.Visible.Value &&
                             (((p.ValidFrom.HasValue && DateTime.Now >= p.ValidFrom)
                              && (p.ValidTo.HasValue && DateTime.Now <= p.ValidTo)) ||
                               (p.ValidFrom.HasValue && DateTime.Now >= p.ValidFrom))
                         orderby p.Priority ascending 
                         select p);

            return pages;
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Show(string id)
        {
            StructureViewModel vm = new StructureViewModel();
            Populate();

            try
            {               
                Guid guid = new Guid(id);

                var acco = (from a in _context.Accommodations where a.Id.Equals(guid) select a).FirstOrDefault<Accommodation>();

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

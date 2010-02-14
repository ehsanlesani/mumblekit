﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using Mumble.Web.StarterKit.Models;
using System.Collections;
using Mumble.Web.StarterKit.Models.Common;
using Mumble.Web.StarterKit.Models.ExtPartial;

namespace Mumble.Web.StarterKit.Controllers.Site
{
    public class HomeController : BaseController
    {
        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public ActionResult Index()
        {
            try
            {
                Populate();
                ViewData["RegionItems"] = GetRegionsSelectList();
                ViewData["Category"] = GetAccommodationTypeList();
                ViewData["Showcase"] = GetOnShowCaseAccomodations();
            }
            catch (Exception)
            {
                throw;
            }

            return View();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult StaticPage(string id) 
        {
            try
            {
                Populate();
                ViewData["Body"] = GetPage(id);                
            }
            catch (Exception)
            {
            }

            return View();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        private Page GetPage(string id)
        {
            StarterKitContainer context = new StarterKitContainer();
            string pageName = id.Replace("_", " ");
            var page = (from p in context.Pages 
                            where 
                            p.Description.Equals(pageName) && 
                            (DateTime.Today >= p.ValidFrom  &&
                            DateTime.Today <= p.ValidTo)
                        orderby p.Priority ascending select p).FirstOrDefault<Page>();

            return page;
        }
        
        private IEnumerable<Accommodation> GetOnShowCaseAccomodations()
        {
            StarterKitContainer context = new StarterKitContainer();
            var showcased = (from a in context.Accommodations where a.OnShowcase == true select a).AsEnumerable<Accommodation>();

            return showcased;
        }

        private IEnumerable<SelectListItem> GetAccommodationTypeList() 
        {
            StarterKitContainer context = new StarterKitContainer();
            var atypes = (from a in context.AccommodationTypes orderby a.Name select a);

            IList<SelectListItem> items = new List<SelectListItem>();
            foreach (AccommodationType a in atypes)
            {
                SelectListItem s = new SelectListItem();
                s.Text = a.Name;
                s.Value = a.Name.Replace(" ", "_");
                items.Add(s);
            }

            return items;
        }

        private IEnumerable<SelectListItem> GetRegionsSelectList() 
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

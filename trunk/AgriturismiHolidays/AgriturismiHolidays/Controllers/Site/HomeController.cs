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
using Mumble.Web.StarterKit.Models.ViewModels;
using Mumble.Web.StarterKit.Models.Auth;
using Mumble.Web.StarterKit.Models.Site;

namespace Mumble.Web.StarterKit.Controllers.Site
{
    public class HomeController : AuthController
    {
        public ActionResult LandingAction(string Error) 
        {
            return RedirectToAction("Index", new { error = Error });
        }

        protected void Populate()
        {
            ViewData["MenuTabs"] = MenuTab.GetMenuItems();
            ViewData["Footer"] = MenuTab.GetGlobalPages();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <returns></returns>
        public ActionResult Index(string error)
        {
            LoginModel loginModel = new LoginModel();

            try
            {
                Populate();
                ViewData["RegionItems"] = Common.GetRegionsSelectList(null);
                ViewData["Category"] = Common.GetAccommodationTypeList();
                ViewData["Showcase"] = GetOnShowCaseAccomodations();

                StarterKitContainer context = new StarterKitContainer();
                Page page = (from p in context.Pages
                             where p.Sections.Description.Trim().Equals("front") &&
                                 (p.Visible.HasValue && p.Visible.Value)
                             select p).FirstOrDefault();
                                
                ViewData["StaticPage"] = (page!=null) ? page.Body : null;

                loginModel.RedirectUrl = Url.Action("PersonalPage", "Account");

                if (!String.IsNullOrEmpty(error) && error.Length > 0)
                    loginModel.Error = error;
            }
            catch (Exception)
            {
                throw;
            }

            ViewData["Login"] = loginModel;

            return View();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult StaticPage(string id) 
        {
            LoginModel loginModel = new LoginModel();

            try
            {
                Populate();
                ViewData["Body"] = GetPage(id);
                loginModel.RedirectUrl = Url.Action("PersonalPage", "Account");
            }
            catch (Exception)
            {
                throw; 
            }

            ViewData["Login"] = loginModel;

            return View();
        }

        /// <summary>
        /// 
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        private Page GetPage(string id)
        {
            // && (DateTime.Today >= p.ValidFrom  &&
            // DateTime.Today <= p.ValidTo)

            StarterKitContainer context = new StarterKitContainer();
            string pageName = id.Replace("_", " ");
            var page = (from p in context.Pages 
                            where 
                            p.Description.Equals(pageName) && (p.Visible.HasValue && p.Visible.Value)
                        orderby p.Priority ascending select p).FirstOrDefault<Page>();

            return page;
        }
        
        private IEnumerable<Accommodation> GetOnShowCaseAccomodations()
        {
            StarterKitContainer context = new StarterKitContainer();
            var showcased = (from a in context.Accommodations 
                                where a.OnShowcase == true //&&
                                 //((a.ValidFrom.HasValue && DateTime.Now >= a.ValidFrom)
                                 //&& (a.ValidTo.HasValue && DateTime.Now <= a.ValidTo))
                                select a).AsEnumerable<Accommodation>();

            return showcased;
        }


    }
}

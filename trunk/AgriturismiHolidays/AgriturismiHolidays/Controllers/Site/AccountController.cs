﻿using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using System.Web.UI;
using System.Diagnostics;
using System.Threading;
using System.IO;
using Newtonsoft.Json;
using Mumble.Web.StarterKit.Models;
using Mumble.Web.StarterKit.Models.ExtPartial;
using Mumble.Web.StarterKit.Models.Exceptions;
using Mumble.Web.StarterKit.Models.Helpers;
using Mumble.Web.StarterKit.Models.ViewModels;
using Mumble.Web.StarterKit.Models.Auth;
using Mumble.Web.StarterKit.Models.Common;


namespace Mumble.Web.StarterKit.Controllers.Site
{

    [HandleError]
    public class AccountController : AuthController
    {
        public ActionResult Register()
        {
            LoginModel loginModel = new LoginModel();
            loginModel.RedirectUrl = Url.Action("PersonalPage", "Account");

            ViewData["Login"] = loginModel;

            return View();
        }

        /// <summary>
        /// Execute user login and render redirect/home page
        /// </summary>
        /// <param name="email"></param>
        /// <param name="password"></param>
        /// <param name="redirectUrl"></param>
        /// <returns></returns>
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Login(string email, string password, string redirectUrl)
        {
            try
            {
                AccountManager accountManager = new AccountManager(UsersContainer);
                accountManager.Login(email, password);
            }
            catch (LoginException)
            {
                return RedirectToAction("LandingAction", "Home", new { error = UIHelper.Translate("err.badLogin") });
                /*
                return View(new LoginModel()
                {
                    Error = UIHelper.Translate("err.badLogin"),
                    RedirectUrl = redirectUrl
                });
                */
            }

            if (String.IsNullOrEmpty(redirectUrl))
            {
                return RedirectToAction("Index", "Home", null);
            }
            else
            {
                return Redirect(redirectUrl);
            }
        }

        /// <summary>
        /// Go to login page. Specify a redirectUrl from an unauthorized page
        /// </summary>
        /// <param name="redirectUrl"></param>
        /// <returns></returns>
        public ActionResult Login(string redirectUrl)
        {
            //if redirecturl was sended, the action was called by an unauthorized user
            LoginModel model = new LoginModel();
            if (redirectUrl != null)
            {
                model.Error = UIHelper.Translate("err.unauthorized");
                model.RedirectUrl = redirectUrl;
            }

            ViewData["Login"] = model;

            return View();
        }

        public ActionResult Logout() 
        {
            return RedirectToAction("LandingAction", "Home", new { error = UIHelper.Translate("err.badLogin") });
        }

        /// <summary>
        /// Register new user and logon if ok
        /// </summary>
        /// <param name="firstName"></param>
        /// <param name="lastName"></param>
        /// <param name="email"></param>
        /// <param name="password"></param>
        /// <param name="gender"></param>
        /// <param name="birthday_day"></param>
        /// <param name="birthday_month"></param>
        /// <param name="birthday_year"></param>
        /// <param name="farmID"></param>
        /// <returns>SimpleResponse JSON</returns>
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Register(
            string firstName,
            string lastName,
            string email,
            string password)
        {
            try
            {
                UsersContainer container = new UsersContainer();
                AccountManager accountManager = new AccountManager(container);
                accountManager.Register(firstName, lastName, email, password);
            }
            catch (ExistingEmailException ex)
            {
                return this.CamelCaseJson(new SimpleResponse(true, String.Format(UIHelper.Translate("msg.existentEmail"), ex.Email)));
            }
            catch (ArgumentOutOfRangeException)
            {
                return this.CamelCaseJson(new SimpleResponse(true, UIHelper.Translate("msg.checkBirthday")));
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex);
                return this.CamelCaseJson(new SimpleResponse(true, UIHelper.Translate("err.registrationProblem")));
            }

            return this.CamelCaseJson(new SimpleResponse(false, UIHelper.Translate("msg.registered")));
        }

        protected void Populate()
        {
            ViewData["MenuTabs"] = MenuTab.GetMenuItems();
            ViewData["Footer"] = MenuTab.GetGlobalPages();
        }

        public ActionResult PersonalPage() 
        {
            Populate();
            LoginModel loginModel = new LoginModel();
            loginModel.RedirectUrl = Url.Action("PersonalPage", "Account");
            ViewData["Login"] = loginModel;

            return View();
        }
    }
}

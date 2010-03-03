using System;
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
using Mumble.Web.StarterKit.Models.Site;
using System.Data;


namespace Mumble.Web.StarterKit.Controllers.Site
{

    [HandleError]
    public class AccountController : AuthController
    {
        private string Error { get; set; }
        private string JsonValue { get; set; }
        private string Name { get; set; }
        private Guid? SelectedAccommodationType { get; set; }
        private string Description { get; set; }
        private string EMail { get; set; }
        private string Tel { get; set; }
        private string Street { get; set; }
        private string StreetNr { get; set; }
        private string Cap { get; set; }
        private string WhereWeAre { get; set; }
        private string Fax { get; set; }
        private Guid? SelectedMunicipality { get; set; }
        private int? Stars {get; set; }
        private Guid? RegionId { get; set; }

        public AccountController() 
        {
            JsonValue = "";
            Error = "";
        }

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
                AccountManager accountManager = new AccountManager(StarterKitContainer);
                accountManager.Login(email, password);
            }
            catch (LoginException)
            {
                return RedirectToAction("Index", "Home", new { error = UIHelper.Translate("err.badLogin") });
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
            AccountManager.Logout();
            return RedirectToAction("Index", "Home", null);
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
                AccountManager accountManager = new AccountManager(StarterKitContainer);
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

        public ActionResult PersonalPage() 
        {
            BasicPageData();

            return View("PersonalPage");
        }

        private void BasicPageData() 
        {
            ViewData["MenuTabs"] = MenuTab.GetMenuItems();
            ViewData["Footer"] = MenuTab.GetGlobalPages();
            LoginModel loginModel = new LoginModel();
            loginModel.RedirectUrl = Url.Action("PersonalPage", "Account");
            ViewData["Login"] = loginModel;
            
            BindPropertiesToViewData();
        }

        private void BindPropertiesToViewData() 
        {            
            ViewData["Error"] = Error;
            ViewData["JsonValue"] = JsonValue;
            ViewData["Name"] = Name;
            ViewData["SelectedAccommodationType"] = SelectedAccommodationType;
            ViewData["Description"] = Description;
            ViewData["EMail"] = EMail;
            ViewData["Tel"] = Tel;
            ViewData["Street"] = Street;
            ViewData["StreetNr"] = StreetNr;
            ViewData["Cap"] = Cap;
            ViewData["WhereWeAre"] = WhereWeAre;
            ViewData["Fax"] = Fax;
            ViewData["Stars"] = Stars.GetValueOrDefault();
            ViewData["SelectedMunicipality"] = SelectedMunicipality;
            ViewData["AccommodationType"] = Common.GetAccommodationTypes(SelectedAccommodationType);
            ViewData["selectionCity"] = Common.GetRegionsSelectList(RegionId);
        }
        
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult RegisterAccommodation(string name, 
                                                    Guid? accommodationType,   
                                                    string description, 
                                                    string email, 
                                                    string tel, 
                                                    string street, 
                                                    string streetnr, 
                                                    string cap,
                                                    string whereweare,
                                                    string fax,
                                                    Guid? municipality,
                                                    int? stars,
                                                    string jpegAttachments) 
        {
            Attachments attach = new Attachments();

            try
            {
                Name = name;
                SelectedAccommodationType = accommodationType;
                Description = description;
                EMail = email;
                Tel = tel;
                Street = street;
                StreetNr = streetnr;
                Cap = cap;
                WhereWeAre = whereweare;
                Fax = fax;
                Stars = stars;
                SelectedMunicipality = municipality;
                JsonValue = jpegAttachments;
                                               
                var tmpObj = (from u in StarterKitContainer.Users where u.Id == AccountManager.LoggedUser.Id select new { User = u, Acco = u.Accommodations }).FirstOrDefault();
                var a = tmpObj.Acco;
                var usr = tmpObj.User;


                if (accommodationType == null || 
                    String.IsNullOrEmpty(name) || 
                    String.IsNullOrEmpty(description) ||
                    String.IsNullOrEmpty(email) ||
                    String.IsNullOrEmpty(tel))
                    throw new Exception("compilare tutti i campi obbligatori ");

                if (stars.HasValue)
                    if (stars.Value < 0 || stars.Value > 5)
                        throw new Exception("Il numero di stelle deve essere compreso tra 0 e 5");

                if (a == null)
                {
                    a = new Accommodation();
                    StarterKitContainer.AddToAccommodations(a);
                }

                EntityKey accTypeKey = new EntityKey("StarterKitContainer.AccommodationTypes", "Id", accommodationType);
                EntityKey userKey = new EntityKey("StarterKitContainer.Users", "Id", this.AccountManager.LoggedUser.Id);
                EntityKey municipalityKey = new EntityKey("StarterKitContainer.Municipalities", "Id", municipality);

                a.Id = Guid.NewGuid();                
                a.Name = name;
                a.Description = description;
                a.Email = email;
                a.Tel = tel;
                a.Street = street;
                a.StreetNr = streetnr;
                a.Cap = cap;
                a.WhereWeAre = whereweare;
                a.Fax = fax;
                a.Quality = stars;
                a.AccommodationTypeReference.EntityKey = accTypeKey;
                a.MunicipalitiesReference.EntityKey = municipalityKey;
                a.Users.Add(usr);

                attach.Convert(jpegAttachments, a, StarterKitContainer);
                StarterKitContainer.SaveChanges();
            }
            catch (FormatException ex)
            {
                Error = ex.Message;
            }
            catch (Exception ex)
            {                
                Error = ex.Message;
            }
            

            return PersonalPage();
        }
    }
}

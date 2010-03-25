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

        public AccountController() 
        {
            JsonValue = "";
            Error = "";            
        }

        private void InitializeProperties() 
        {
            var accommodation = (from u in StarterKitContainer.Users where u.Id == AccountManager.LoggedUser.Id select u.Accommodations).FirstOrDefault();

            if (accommodation != null)
            {
                if (!accommodation.MunicipalitiesReference.IsLoaded)
                    accommodation.MunicipalitiesReference.Load();

                if (!accommodation.AccommodationTypeReference.IsLoaded)
                    accommodation.AccommodationTypeReference.Load();

                Name = accommodation.Name;
                Description = accommodation.Description;
                EMail = accommodation.Email;
                Tel = accommodation.Tel;
                Street = accommodation.Street;
                StreetNr = accommodation.StreetNr;
                Cap = accommodation.Cap;
                WhereWeAre = accommodation.WhereWeAre;
                Fax = accommodation.Fax;
                Stars = accommodation.Quality;
                SelectedMunicipality = accommodation.Municipalities.Id;
                SelectedAccommodationType = accommodation.AccommodationType.Id;
                Attachments att = new Attachments();
                JsonValue = att.Convert(accommodation);
            }
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
            if (!AccountManager.HasLoggedUser)
                return RedirectToAction("Index", "Home");

            InitializeProperties();
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

            // Initialized statically
            ViewData["AccommodationType"] = Common.GetAccommodationTypes(SelectedAccommodationType);
            //ViewData["Rooms"] = Common.GetAccommodationTypes(SelectedAccommodationType);
            ViewData["NewRoomType"] = Common.GetRoomTypes();
            ViewData["Seasons"] = Common.GetSeasons();

            InitializeLocalityHierarchy();
        }

        private void InitializeLocalityHierarchy() 
        {
            if (SelectedMunicipality != null)
            {
                var tmpObj = (from m in StarterKitContainer.Municipalities
                              join p in StarterKitContainer.Provinces
                                  on m.Provinces equals p
                              join r in StarterKitContainer.Regions
                                  on p.Region equals r
                              where m.Id == SelectedMunicipality
                              select new
                                {
                                    Province = m.Provinces,
                                    Region = m.Provinces.Region
                                }).FirstOrDefault();

                ViewData["selectionCity"] = Common.GetRegionsSelectList(tmpObj.Region.Id);
                ViewData["selectionProvince"] = Common.GetProvincesSelectList(tmpObj.Province.Id, tmpObj.Region.Id);
                ViewData["selectionMunicipality"] = Common.GetMunicipalitiesSelectList(SelectedMunicipality, tmpObj.Province.Id);
            }
            else 
            {
                ViewData["selectionCity"] = Common.GetRegionsSelectList(null);
                ViewData["selectionMunicipality"] = null;
                ViewData["selectionProvince"] = null;
            }
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
                                                    Guid? selectionMunicipality,
                                                    int? stars,
                                                    int? roomCounter,
                                                    string jpegAttachments, 
                                                    FormCollection form)
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
                SelectedMunicipality = selectionMunicipality;
                JsonValue = jpegAttachments;
                                               
                var tmpObj = (from u in StarterKitContainer.Users where u.Id == AccountManager.LoggedUser.Id select new { User = u, Acco = u.Accommodations }).FirstOrDefault();
                var a = tmpObj.Acco;
                var usr = tmpObj.User;


                if (accommodationType == null || 
                    String.IsNullOrEmpty(name) || 
                    String.IsNullOrEmpty(description) ||
                    String.IsNullOrEmpty(email) ||
                    String.IsNullOrEmpty(tel) ||
                    !selectionMunicipality.HasValue)
                    throw new Exception("compilare tutti i campi obbligatori ");

                if (stars.HasValue)
                    if (stars.Value < 0 || stars.Value > 5)
                        throw new Exception("Il numero di stelle deve essere compreso tra 0 e 5");

                if (a == null)
                {
                    a = new Accommodation();
                    StarterKitContainer.AddToAccommodations(a);
                    a.Id = Guid.NewGuid(); 
                }

                EntityKey accTypeKey = new EntityKey("StarterKitContainer.AccommodationTypes", "Id", accommodationType);
                EntityKey userKey = new EntityKey("StarterKitContainer.Users", "Id", this.AccountManager.LoggedUser.Id);
                EntityKey municipalityKey = new EntityKey("StarterKitContainer.Municipalities", "Id", selectionMunicipality);
                
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

                if (roomCounter.GetValueOrDefault() > 0)
                    GenerateRoomList(a, form, roomCounter.Value);

                attach.Convert(jpegAttachments, a, StarterKitContainer);
                StarterKitContainer.SaveChanges();
            }
            catch (FormatException ex)
            {
                Error = ex.Message;
            }
            catch (Exception ex)
            {    
                #if(DEBUG)
                    throw;
                #else
                    Error = "Errore generico";
                #endif
            }
            

            return PersonalPage();
        }

        private void GenerateRoomList(Accommodation a, FormCollection frm, int max) 
        {
            for (int i = 0; i < max; i++) 
            {
                EntityKey accommodationKey = new EntityKey("StarterKitContainer.Accommodations", "Id", a.Id);

                Room r = new Room();
                r.Name = frm["roomName_" + i];                
                r.Persons = Int32.Parse(frm["roomPersons_" + i]);
                r.Id = Guid.NewGuid();
                r.AccommodationsReference.EntityKey = accommodationKey;

                StarterKitContainer.AddToRooms(r);
                //StarterKitContainer.SaveChanges();                

                var roomType = frm["NewRoomType_" + i];
                Guid gID = new Guid(roomType);
                EntityKey entryKey = new EntityKey("StarterKitContainer.PriceListEntries", "Id", gID);
                EntityKey roomKey = new EntityKey("StarterKitContainer.Rooms", "Id", r.Id);                

                var seasonList = (from s in StarterKitContainer.PriceListSeasons select s.Id);

                foreach (Guid id in seasonList) 
                {
                    // prepare data to store
                    string domSeasonId = id + "_" + i;
                    string myPrice = frm[domSeasonId];

                    decimal res = 0;                    
                    if (!decimal.TryParse(myPrice, NumberStyles.Currency, CultureInfo.InvariantCulture, out res))
                        throw new FormatException("prezzo camere non valido");

                    EntityKey seasonKey = new EntityKey("StarterKitContainer.PriceListSeasons", "Id", id);
                    
                    // Create Obj and store
                    RoomPriceList roomPrice = new RoomPriceList();

                    roomPrice.Id = Guid.NewGuid();
                    roomPrice.RoomsReference.EntityKey = roomKey;
                    roomPrice.PriceListEntriesReference.EntityKey = entryKey;
                    roomPrice.PriceListSeasonsReference.EntityKey = seasonKey;
                    roomPrice.Price = res;

                    StarterKitContainer.AddToRoomPriceList(roomPrice);
                    //StarterKitContainer.SaveChanges();                    
                }                
            }            
        }
    }
}

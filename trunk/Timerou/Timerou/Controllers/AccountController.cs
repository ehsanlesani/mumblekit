using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using System.Web.UI;
using Mumble.Timerou.Models;
using Mumble.Timerou.Models.Responses;
using Mumble.Timerou.Models.Managers;
using Mumble.Timerou.Models.Exceptions;
using Mumble.Timerou.Models.Helpers;
using System.Diagnostics;
using Mumble.Timerou.Models.Controls;
using System.Threading;
using Mumble.Timerou.Models.Auth;
using System.IO;
using Newtonsoft.Json;
using Mumble.Timerou.Models.Pages;

namespace Mumble.Timerou.Controllers
{

    public class AccountController : AuthController
    {
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
            ViewData["debug"] = String.Format("{0}, {1}, {2}", email, password, redirectUrl);
            
            try
            {
                AccountManager accountManager = new AccountManager(Container);
                accountManager.Login(email, password);
            }
            catch (LoginException)
            {
                return View("Login", new LoginModel()
                {
                    Error = UIHelper.Translate("err.badLogin"),
                    RedirectUrl = redirectUrl
                });
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
            return View(model);
        }

        /// <summary>
        /// Render registration form
        /// </summary>
        /// <returns></returns>
        public ActionResult Register()
        {
            return View();
        }

        /// <summary>
        /// Render share form
        /// </summary>
        /// <returns></returns>
        public ActionResult Share(Guid? id, float? lat, float? lng, int? zoom, int? year)
        {
            try
            {
                Authorize();

                UploadModel model = new UploadModel();

                if (id.HasValue)
                {
                    model.Picture = Container.Medias.OfType<Picture>().Where(p => p.Id == id).First();
                }

                if (lat.HasValue) { model.Lat = lat.Value; }
                if (lng.HasValue) { model.Lng = lng.Value; }
                if (zoom.HasValue) { model.Zoom = zoom.Value; }
                if (year.HasValue) { model.Year = year.Value; }

                return View(model);
            }
            catch (AuthException)
            {
                return RedirectToAction("Login", "Account", new { redirectUrl = Url.Action("Share", "Account") });
            }            
        }

        /// <summary>
        /// Render logged user media manager
        /// </summary>
        /// <returns></returns>
        public ActionResult MyMemories()
        {
            try
            {
                Authorize();



                return View();
            }
            catch (AuthException)
            {
                return RedirectToAction("Login", "Account", new { redirectUrl = Url.Action("MyMemories", "Account") });
            } 
        }

        /// <summary>
        /// Save picture information
        /// </summary>
        /// <param name="pictureId"></param>
        /// <param name="tempPictureId"></param>
        /// <param name="title"></param>
        /// <param name="body"></param>
        /// <param name="country"></param>
        /// <param name="countryCode"></param>
        /// <param name="region"></param>
        /// <param name="postalCode"></param>
        /// <param name="city"></param>
        /// <param name="province"></param>
        /// <param name="address"></param>
        /// <param name="lat"></param>
        /// <param name="lng"></param>
        /// <returns></returns>
        [ValidateInput(false)]
        public ActionResult SavePicture(
            Guid? pictureId, //editing picture id. if null is a new picture
            Guid? tempPictureId, 
            string title,
            string body,
            string country, 
            string countryCode, 
            string region, 
            string postalCode, 
            string city, 
            string province, 
            string address, 
            string lat,
            string lng,
            int year,
            bool? goToNewPicture)
        {
            try
            {
                Authorize();

                //load english culture for float parsing
                CultureInfo culture = CultureInfo.GetCultureInfo("en-US");
                double dLat = double.Parse(lat, culture.NumberFormat);
                double dLng = double.Parse(lng, culture.NumberFormat);

                ControlPanel controlPanel = new ControlPanel(AccountManager.LoggedUser, Container);
                Picture picture = controlPanel.SavePicture(
                    pictureId, 
                    tempPictureId, 
                    title, 
                    body, 
                    country, 
                    countryCode, 
                    region, 
                    postalCode, 
                    city, 
                    province, 
                    address, 
                    dLat, 
                    dLng,
                    year);

                if (goToNewPicture.HasValue && goToNewPicture.Value)
                {
                    return RedirectToAction("Show", "Pictures", new { id = picture.Id });
                }
                else
                {
                    ViewData["Message"] = UIHelper.Translate("msg.pictureSaved");
                    return RedirectToAction("Upload", "Account", new { message = UIHelper.Translate("msg.pictureSaved") });
                }
            }
            catch (AuthException)
            {
                return RedirectToAction("Login", "Account", new { redirectUrl = Url.Action("Upload", "Account") });
            }
            
        }

        #region Ajax

        /// <summary>
        /// Load current users media
        /// </summary>
        /// <param name="keyword"></param>
        /// <param name="year"></param>
        /// <param name="page"></param>
        /// <param name="pageSize"></param>
        /// <returns></returns>
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult LoadUserMedias(string keyword, int? year, int page, int pageSize)
        {
            SimpleResponse response = null;

            try
            {
                Authorize();

                int totalCount = 0;
                MediaLoader loader = new MediaLoader(Container);
                var medias = loader.LoadUserMedias(AccountManager.LoggedUser, keyword, year, page, pageSize, out totalCount);

                response = LoadMediasResponse.FromList(medias, true);
                ((LoadMediasResponse)response).TotalCount = totalCount;
            }
            catch (AuthException)
            {
                response = new SimpleResponse(true, UIHelper.Translate("err.unauthorized"));
            }
            catch (Exception ex)
            {
                response = new SimpleResponse(true, ex.Message);
            }

            return this.CamelCaseJson(response);
        }

        /// <summary>
        /// Register new user and logon if ok. This is an ajax post
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
                AccountManager accountManager = new AccountManager(Container);
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

        /// <summary>
        /// Change current thread culture. This is an ajax call
        /// </summary>
        /// <param name="culture"></param>
        /// <returns></returns>
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult ChangeCulture(string culture)
        {
            try
            {
                UIHelper.ChangeCulture(culture);

                return this.CamelCaseJson(new SimpleResponse(false, "Culture changed"));
            }
            catch (Exception ex)
            {
                return this.CamelCaseJson(new SimpleResponse(true, ex.Message));
            }
        }

        /// <summary>
        /// Load pictures of specified user. This is an ajax call
        /// </summary>
        /// <param name="albumId"></param>
        /// <returns></returns>
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult LoadPictures(string lat, string lng)
        {
            try
            {
                LoadMediasResponse response = new LoadMediasResponse(false, "");

                return this.CamelCaseJson(response);
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex);
                return this.CamelCaseJson(new SimpleResponse(true, ex.Message));
            }
        }

        /// <summary>
        /// Delete logged user media by Id
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult DeleteUserMedia(Guid id)
        {
            SimpleResponse response = null;

            try
            {
                Authorize();

                ControlPanel controlPanel = new ControlPanel(AccountManager.LoggedUser, Container);
                //controlPanel.DeleteMedia(id);

                response = new SimpleResponse(false, "Media deleted");
            }
            catch (AuthException)
            {
                response = new SimpleResponse(true, UIHelper.Translate("err.unauthorized"));
            }
            catch (Exception ex)
            {
                response = new SimpleResponse(true, ex.Message);
            }

            return this.CamelCaseJson(response);
        }

        /// <summary>
        /// Add a temp picture to current user. This action result is not a json because this method is called by ajax uploader from an iframe
        /// </summary>
        /// <param name="albumId"></param>
        /// <returns></returns>
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult AddPicture()
        {
            SimpleResponse response = null;

            try
            {
                Authorize();

                //Get file from post
                HttpPostedFileBase file = Request.Files[0];

                if (file.ContentLength == 0)
                {
                    throw new Exception("File not specified");
                }

                //check extension
                string extension = Path.GetExtension(file.FileName).ToLower();
                if (extension != ".jpg" && extension != ".jpeg")
                {
                    throw new FormatException();
                }

                ControlPanel controlPanel = new ControlPanel(AccountManager.LoggedUser, Container);
                Picture picture = controlPanel.CreateTempPicture(file.InputStream);

                response = AddMediaResponse.FromPicture(picture);
            }
            catch (AuthException)
            {
                response = new SimpleResponse(true, UIHelper.Translate("err.unauthorized"));
            }
            catch (FormatException)
            {
                response = new SimpleResponse(true, UIHelper.Translate("err.formatNotAllowed"));
            }
            catch (Exception ex)
            {
                response = new SimpleResponse(true, ex.Message);
            }

            string json = JsonConvert.SerializeObject(response, Formatting.Indented, new JsonSerializerSettings() { ContractResolver = new Newtonsoft.Json.Serialization.CamelCasePropertyNamesContractResolver() });
            return Content(json);
        }

        #endregion
    }
}

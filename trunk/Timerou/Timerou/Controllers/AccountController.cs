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

namespace Mumble.Timerou.Controllers
{

    [HandleError]
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
            try
            {
                AccountManager accountManager = new AccountManager(Container);
                accountManager.Login(email, password);
            }
            catch (LoginException)
            {
                return View(new LoginModel() { 
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
        /// Render user control panel. Needs user login
        /// </summary>
        /// <returns></returns>
        public ActionResult ControlPanel()
        {
            try
            {
                Authorize();
            }
            catch (AuthException)
            {
                return RedirectToAction("Login", "Account", new { redirectUrl = Url.Action("ControlPanel", "Account") });
            }

            return View();
        }

        #region Ajax

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
                LoadPicturesResponse response = new LoadPicturesResponse(false, "");

                return this.CamelCaseJson(response);
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex);
                return this.CamelCaseJson(new SimpleResponse(true, ex.Message));
            }
        }

        /// <summary>
        /// Add a picture to specified user. This action result is not a json because this method is called by ajax uploader from an iframe
        /// </summary>
        /// <param name="albumId"></param>
        /// <returns></returns>
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult AddPicture(float lat, float lng)
        {
            SimpleResponse response = null;

            try
            {
                Authorize();

                User user = AccountManager.LoggedUser;
                //Get file from post
                HttpPostedFileBase file = Request.Files[0];

                Picture picture = new Picture();

                response = AddPictureResponse.FromPicture(picture);
            }
            catch (AuthException)
            {
                response = new SimpleResponse(true, UIHelper.Translate("err.unauthorized"));
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

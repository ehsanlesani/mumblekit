using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Security.Principal;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using System.Web.UI;
using Mumble.Friendsheep.Models;
using Mumble.Friendsheep.Models.Responses;
using Mumble.Friendsheep.Models.Managers;
using Mumble.Friendsheep.Models.Exceptions;
using Mumble.Friendsheep.Models.Helpers;
using System.Diagnostics;
using Mumble.Friendsheep.Models.Controls;
using System.Threading;
using Mumble.Friendsheep.Models.Auth;
using System.IO;

namespace Friendsheep.Controllers
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
            string password,
            Gender gender,
            int birthday_day,
            int birthday_month,
            int birthday_year,
            Guid farmID)
        {
            try
            {
                AccountManager accountManager = new AccountManager(Container);
                Farm farm = Container.Farms.Where(f => f.Id == farmID).First();
                DateTime birtday = new DateTime(birthday_year, birthday_month, birthday_day);
                accountManager.Register(firstName, lastName, email, password, gender, birtday, farm);
            }
            catch (ExistingEmailException ex)
            {
                return Json(new SimpleResponse(true, String.Format(UIHelper.Translate("msg.existentEmail"), ex.Email)));
            }
            catch (ArgumentOutOfRangeException)
            {
                return Json(new SimpleResponse(true, UIHelper.Translate("msg.checkBirthday")));
            }
            catch (Exception ex)
            {
                Debug.WriteLine(ex);
                return Json(new SimpleResponse(true, UIHelper.Translate("err.registrationProblem")));
            }

            return Json(new SimpleResponse(false, UIHelper.Translate("msg.registered")));
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

                return Json(new SimpleResponse(false, "Culture changed"));
            }
            catch (Exception ex)
            {
                return Json(new SimpleResponse(true, ex.Message));
            }
        }

        /// <summary>
        /// Create a new pictures album for current user. This is an ajax call
        /// </summary>
        /// <returns></returns>
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult CreateAlbum(string title)
        {
            try
            {
                Authorize();

                ControlPanel controlPanel = new ControlPanel(AccountManager.LoggedUser, Container);
                Album album = controlPanel.CreateAlbum();

                return Json(new CreateAlbumResponse(false, "Album created", album.Id, album.Title));

            }
            catch (AuthException)
            {
                return Json(new SimpleResponse(true, UIHelper.Translate("err.unauthorized")));
            }
            catch (Exception ex)
            {
                return Json(new SimpleResponse(true, ex.Message));
            }
        }

        /// <summary>
        /// Load pictures of specified album. This is an ajax call
        /// </summary>
        /// <param name="albumId"></param>
        /// <returns></returns>
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult LoadPictures(Guid albumId)
        {
            try
            {
                Authorize();

                Album album = AccountManager.LoggedUser.Albums.Where(a => a.Id == albumId).First();
                LoadPicturesResponse response = LoadPicturesResponse.FromAlbum(album);

                return Json(response);
            }
            catch (AuthException)
            {
                return Json(new SimpleResponse(true, UIHelper.Translate("err.unauthorized")));
            }
            catch (Exception ex)
            {
                return Json(new SimpleResponse(true, ex.Message));
            }
        }

        /// <summary>
        /// Add a picture to specified album. This is an ajax call
        /// </summary>
        /// <param name="albumId"></param>
        /// <returns></returns>
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult AddPicture(Guid albumId)
        {
            try
            {
                Authorize();

                Album album = AccountManager.LoggedUser.Albums.Where(a => a.Id == albumId).First();
                
                //Get file from post
                HttpPostedFileBase file = Request.Files[0];

                ControlPanel controlPanel = new ControlPanel(AccountManager.LoggedUser, Container);
                Picture picture = controlPanel.SavePicture(album, file.InputStream, file.FileName);

                AddPictureResponse response = AddPictureResponse.FromPicture(picture);

                return Json(response);
            }
            catch (AuthException)
            {
                return Json(new SimpleResponse(true, UIHelper.Translate("err.unauthorized")));
            }
            catch (Exception ex)
            {
                return Json(new SimpleResponse(true, ex.Message));
            }
        }

        #endregion
    }
}

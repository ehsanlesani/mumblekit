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


namespace Mumble.Web.StarterKit.Controllers.Site
{

    [HandleError]
    public class AccountController : BaseController
    {
        public ActionResult Register()
        {
            Populate();
            return View();
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

    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using Mumble.Timerou.Models;
using Mumble.Timerou.Models.Managers;
using Mumble.Timerou.Models.Exceptions;

namespace Mumble.Timerou.Models.Auth
{
    /// <summary>
    /// Represents a controller that needs authorization functions
    /// </summary>
    public class AuthController : Controller
    {
        /// <summary>
        /// Gets or sets container
        /// </summary>
        public TimerouContainer Container { get; set; }

        /// <summary>
        /// Gets or sets account manager
        /// </summary>
        public AccountManager AccountManager { get; set; }

        public AuthController()
        {
            Container = new TimerouContainer();
            AccountManager = new AccountManager(Container);
            
            //send account manager to AuthPage
            ViewData["AccountManager"] = AccountManager;
        }

        /// <summary>
        /// Check if user is logged. If not AuthException is thrown
        /// </summary>
        /// <exception cref="AuthException"></exception>
        protected void Authorize()
        {
            if (!AccountManager.HasLoggedUser)
            {
                throw new AuthException();
            }
        }

    }
}

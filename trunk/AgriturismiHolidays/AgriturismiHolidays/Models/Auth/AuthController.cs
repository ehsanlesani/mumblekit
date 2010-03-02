using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using Mumble.Web.StarterKit.Models.ExtPartial;
using Mumble.Web.StarterKit.Models.Exceptions;

namespace Mumble.Web.StarterKit.Models.Auth
{
    /// <summary>
    /// Represents a controller that needs authorization functions
    /// </summary>
    public class AuthController : Controller
    {
        /// <summary>
        /// Gets or sets container
        /// </summary>
        public StarterKitContainer StarterKitContainer { get; set; }

        /// <summary>
        /// Gets or sets account manager
        /// </summary>
        public AccountManager AccountManager { get; set; }

        public AuthController()
        {
            StarterKitContainer = new StarterKitContainer();
            AccountManager = new AccountManager(StarterKitContainer);
            
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

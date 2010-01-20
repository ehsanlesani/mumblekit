using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Mumble.Friendsheep.Models.Managers;

namespace Mumble.Friendsheep.Models.Auth
{
    public class AuthPage : ViewPage
    {
        public AccountManager AccountManager
        {
            get
            {
                if (ViewData["AccountManager"] == null)
                    throw new InvalidProgramException("AccountManager is null");

                return (AccountManager)ViewData["AccountManager"];
            }
        }
    }
}
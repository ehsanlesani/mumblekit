using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Mumble.Timerou.Models.Managers;

namespace Mumble.Timerou.Models.Auth
{
    public class AuthPage<T> : ViewPage<T>
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
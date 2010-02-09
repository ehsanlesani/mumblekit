using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Mumble.Web.StarterKit.Models.Auth
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
    
    public class AuthPage<T> : ViewPage<T> where T : class
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
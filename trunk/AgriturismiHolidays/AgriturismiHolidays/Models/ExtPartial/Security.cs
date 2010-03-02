using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mumble.Web.StarterKit.Models.ExtPartial;

namespace Mumble.Web.StarterKit.Models
{
    public class Security
    {
        private static Security _instance;

        public static Security Instance 
        {
            get
            {
                if (_instance == null)
                    _instance = new Security();

                return _instance;
            }
        }

        private Security()
        {
            Context = new StarterKitContainer();
        }

        /// <summary>
        /// Gets the users model
        /// </summary>
        public StarterKitContainer Context { get; private set; }

        public bool Login(string email, string password)
        {
            HttpContext.Current.Session.Clear();

            var user = Context.Users.Where(u => u.Email.Equals(email) && u.Password.Equals(password)).FirstOrDefault();
            if (user != null)
            {
                HttpContext.Current.Session.Add("LoggedUserID", user.Id);
                return true;
            }

            return false;
        }

        public void Logout()
        {
            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.Abandon();
        }

        /// <summary>
        /// Return current logged in user. Return none if no users are logged
        /// </summary>
        public User GetLoggedUser()
        {
            if (HttpContext.Current.Session["LoggedUserID"] != null)
            {
                Guid id = (Guid)HttpContext.Current.Session["LoggedUserID"];
                return Context.Users.Where(u => u.Id == id).First();
            }

            return null;
        }

        /// <summary>
        /// Check if current logged in user has specified group
        /// </summary>
        /// <param name="group"></param>
        /// <returns></returns>
        public bool IsGroupEnabled(string group)
        {
            var user = GetLoggedUser();
            if (user != null)
            {
                if (!user.Groups.IsLoaded)
                    user.Groups.Load();

                var count = user.Groups.Where(g => g.Description.Equals(group)).Count();
                return count > 0;
            }

            return false;
        }
    }
}
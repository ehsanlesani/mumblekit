using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mumble.Timerou.Models.Managers;

namespace Mumble.Timerou.Models.Managers
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Web;
    using Mumble.Timerou.Models.Helpers;

    public class AccountManager
    {
        public const string SessionUserKey = "LoggedUserID";

        private User _loggedUser = null;

        /// <summary>
        /// Create new instance of AccountManager with specified context
        /// </summary>
        /// <param name="container"></param>
        public AccountManager(TimerouContainer container)
        {
            Container = container;
        }

        /// <summary>
        /// Create new instance of AccountManager creating new context
        /// </summary>
        public AccountManager()
        {
            Container = new TimerouContainer();
        }

        /// <summary>
        /// Gets the users model
        /// </summary>
        public TimerouContainer Container { get; set; }

        /// <summary>
        /// Log user into site and store id into session
        /// </summary>
        /// <param name="email"></param>
        /// <param name="password"></param>
        /// <exception cref="Mumble.Timerou.Models.Exceptions.LoginException" />
        public void Login(string email, string password)
        {
            var user = Container.Users.Where(u => u.Email.Equals(email) && u.Password.Equals(password)).FirstOrDefault();
            if (user == null)
            {
                throw new Exceptions.LoginException(email, password);
            }
            
            //clear session
            HttpContext.Current.Session.Clear();
            //add session key
            HttpContext.Current.Session.Add(SessionUserKey, user.Id);
            //set current user culture
            UIHelper.ChangeCulture(user.Culture);
        }

        public void Logout()
        {
            _loggedUser = null;
            HttpContext.Current.Session.Clear();
            HttpContext.Current.Session.Abandon();
        }


        /// <summary>
        /// Gets current logged user
        /// </summary>
        public User LoggedUser
        {
            get
            {
                if (_loggedUser == null)
                {
                    if (HttpContext.Current.Session[SessionUserKey] != null)
                    {
                        Guid id = (Guid)HttpContext.Current.Session[SessionUserKey];
                        _loggedUser = Container.Users.Where(u => u.Id == id).First();
                    }
                }

                return _loggedUser;
            }
        }

        /// <summary>
        /// Return true if a user is logged into site
        /// </summary>
        public bool HasLoggedUser
        {
            get { return LoggedUser != null; }
        }

        /// <summary>
        /// Check if current logged in user has specified group
        /// </summary>
        /// <param name="group"></param>
        /// <returns></returns>
        public bool IsGroupEnabled(string group)
        {
            var user = LoggedUser;
            if (user != null)
            {
                if (!user.Groups.IsLoaded)
                    user.Groups.Load();

                var count = user.Groups.Where(g => g.Description.Equals(group)).Count();
                return count > 0;
            }

            return false;
        }

        /// <summary>
        /// Register new user into and send him a confirmation email
        /// </summary>
        /// <param name="firstName"></param>
        /// <param name="lastName"></param>
        /// <param name="email"></param>
        /// <param name="password"></param>
        /// <param name="gender"></param>
        /// <param name="birthday"></param>
        /// <param name="farm"></param>
        /// <exception cref="Mumble.Timerou.Models.Exceptions.ExistingEmailException"></exception>
        public void Register(
            string firstName,
            string lastName,
            string email,
            string password)
        {
            //check email existence into db
            var count = (from u in Container.Users
                         where u.Email == email
                         select u).Count();

            if (count > 0)
            {
                throw new Exceptions.ExistingEmailException(email);
            }

            User user = new User()
            {
                FirstName = firstName,
                LastName = lastName,
                Email = email,
                Password = password,
                Culture = UIHelper.DefaultCulture
            };

            Container.AddToUsers(user);
            Container.SaveChanges();

            Login(email, password);
        }

    }
}

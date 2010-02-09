using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Mumble.Web.StarterKit.Models.Exceptions
{
    public class LoginException : Exception
    {
        public LoginException(string email, string password)
        {
            Email = email;
            Password = password;
        }

        public string Email { get; private set; }
        public string Password { get; private set; }
    }
}

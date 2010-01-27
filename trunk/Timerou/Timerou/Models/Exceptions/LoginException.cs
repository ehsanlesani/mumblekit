using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Mumble.Timerou.Models.Exceptions
{
    public class LoginException : Exception
    {
        public LoginException(string email, string password)
            : base("LoginException was thrown")
        {
            Email = email;
            Password = password;
        }

        public string Email { get; private set; }
        public string Password { get; private set; }
    }
}

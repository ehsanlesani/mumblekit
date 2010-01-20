using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Friendsheep.Models.Exceptions
{
    public class ExistingEmailException : Exception
    {
        public ExistingEmailException(string email) 
            : base("ExistingEmailException was thrown")
        {
            Email = email;
        }

        public string Email { get; private set; }
    }
}
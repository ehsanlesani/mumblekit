using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.Exceptions
{
    public class ExistingEmailException : Exception
    {
        public ExistingEmailException(string email)
        {
            Email = email;
        }

        public string Email { get; private set; }
    }
}
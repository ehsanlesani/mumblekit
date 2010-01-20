using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Friendsheep.Models.Exceptions
{
    public class AuthException : Exception
    {
        public AuthException()
            : base("AuthException was thrown")
        { }
    }
}
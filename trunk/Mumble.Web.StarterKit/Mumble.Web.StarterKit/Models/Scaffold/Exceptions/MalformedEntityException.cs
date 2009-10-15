using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.Scaffold.Exceptions
{
    public class MalformedEntityException : Exception
    {
        public MalformedEntityException(string message)
            : base(message)
        { }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.ExtPartial
{
    public partial class User
    {
        public override string ToString()
        {
            return String.Format("{0} {1} [{2}]", FirstName, LastName, Email);
        }
    }
}
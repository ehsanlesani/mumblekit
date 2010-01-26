using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mumble.Timerou.Models.Helpers;

namespace Mumble.Timerou.Models
{
    public partial class User
    {       
        public override string ToString()
        {
            return String.Format("{0} {1} [{2}]", FirstName, LastName, Email);
        }
    }
}
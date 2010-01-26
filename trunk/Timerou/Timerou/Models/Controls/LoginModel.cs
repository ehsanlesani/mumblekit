using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models.Controls
{
    public class LoginModel
    {
        public string Error { get; set; }
        public string RedirectUrl { get; set; }
        public bool HasError { get { return Error != null; } }
    }
}
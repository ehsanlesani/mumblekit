using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models.ViewData
{
    public class ModelValueAttribute : Attribute
    {
        public bool Default { get; set; }
    }
}

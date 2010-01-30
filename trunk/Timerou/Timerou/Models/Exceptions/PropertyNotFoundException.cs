using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models.Exceptions
{
    public class PropertyNotFoundException : Exception
    {
        public PropertyNotFoundException(string property)
        {
            Property = property;
        }
        
        public string Property { get; set; }
    }
}

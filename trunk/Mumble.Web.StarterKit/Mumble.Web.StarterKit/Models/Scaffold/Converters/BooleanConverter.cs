using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.Scaffold.Converters
{
    public class BooleanConverter : IValueConverter
    {
        public object Convert(string value)
        {
            if (String.IsNullOrEmpty(value))
                return null;

            return value.Equals("true");
        }

        public string Convert(object value)
        {
            if(value == null)
                return "false";
            
            return value.ToString();           
        }
    }
}
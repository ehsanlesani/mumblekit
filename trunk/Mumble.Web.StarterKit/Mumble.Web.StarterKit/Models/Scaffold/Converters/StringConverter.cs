using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.Scaffold.Converters
{
    /// <summary>
    /// Represents the converter for String type
    /// </summary>
    public class StringConverter : IValueConverter
    {
        public object Convert(string value)
        {
            return value;
        }

        public string Convert(object value)
        {
            if(value != null)
                return value.ToString();

            return null;
        }
    }
}
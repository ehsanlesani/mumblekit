using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.Scaffold.Converters
{
    public class Int32Converter : IValueConverter
    {
        public object Convert(string value)
        {
            if (String.IsNullOrEmpty(value))
                return null;

            return Int32.Parse(value);
        }

        public string Convert(object value)
        {
            if(value != null)
                return value.ToString();

            return null;
        }
    }
}
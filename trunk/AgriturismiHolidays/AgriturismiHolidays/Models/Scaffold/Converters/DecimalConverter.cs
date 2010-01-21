using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.Scaffold.Converters
{
    public class DecimalConverter : IValueConverter
    {
        public object Convert(string value)
        {
            if (String.IsNullOrEmpty(value))
                return null;

            return Decimal.Parse(value);
        }

        public string Convert(object value)
        {
            if(value != null)
                return value.ToString();

            return null;
        }
    }
}
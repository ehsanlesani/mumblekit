using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.Scaffold.Converters
{
    public class GuidConverter : IValueConverter
    {
        public object Convert(string value)
        {
            if (string.IsNullOrEmpty(value))
                return null;

            return new Guid(value);
        }

        public string Convert(object value)
        {
            return value.ToString();
        }
    }
}
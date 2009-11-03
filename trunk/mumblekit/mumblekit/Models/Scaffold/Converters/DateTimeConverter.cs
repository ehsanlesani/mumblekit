using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Threading;

namespace Mumble.Web.StarterKit.Models.Scaffold.Converters
{
    public class DateTimeConverter : IValueConverter
    {
        public const string DateFormat = "dd/MM/yyyy";

        public object Convert(string value)
        {
            DateTime dateTime = DateTime.MinValue;
            try
            {
                return DateTime.ParseExact(value, DateFormat, Thread.CurrentThread.CurrentCulture.DateTimeFormat);
            }
            catch(FormatException) { }
            return null;
        }

        public string Convert(object value)
        {
            if (value != null)
            {
                DateTime date = (DateTime)value;
                return date.ToString(DateFormat);
            }
            else
            {
                return DateTime.MinValue.ToString(DateFormat);
            }
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Mumble.Web.StarterKit.Models.Scaffold.Converters
{
    /// <summary>
    /// Define methods to convert values from object to a string for html controls and viceversa
    /// </summary>
    public interface IValueConverter
    {
        object Convert(string value);
        string Convert(object value);
    }
}

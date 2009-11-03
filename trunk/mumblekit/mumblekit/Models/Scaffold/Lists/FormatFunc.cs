using System;

namespace Mumble.Web.StarterKit.Models.Scaffold.Lists
{
    /// <summary>
    /// Value formatter delegate
    /// </summary>
    /// <param name="value"></param>
    /// <returns></returns>
    public delegate string FormatFunc(object value);

    public class Formatters
    {
        public static readonly FormatFunc StandardFormatter = new FormatFunc(o => o != null ? o.ToString() : "");
        public static readonly FormatFunc DateTimeFormatter = new FormatFunc(o => ((DateTime)o).ToString("dd/MM/yyyy"));
    }
}
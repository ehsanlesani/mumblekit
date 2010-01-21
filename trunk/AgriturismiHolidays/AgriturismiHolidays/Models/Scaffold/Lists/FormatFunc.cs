using System;
using System.Collections.Generic;
using System.Text;
using System.Collections;

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

        public static readonly FormatFunc EnumerationFormatter = new FormatFunc((o) =>
            {
                IEnumerable attachments = (IEnumerable)o;
                StringBuilder sb = new StringBuilder();
                foreach (var att in attachments)
                {
                    sb.AppendFormat("{0} - ", att.ToString());

                }

                if (sb.Length > 0)
                {
                    sb.Remove(sb.Length - 3, 3);
                    return sb.ToString();
                }

                return "n/a";
            });
    }
}
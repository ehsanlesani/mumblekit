using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.Scaffold.Lists
{
    public class ColumnConfiguration
    {
        public ColumnConfiguration(string name, string header, FormatFunc formatter)
        {
            Name = name;
            Header = header;
            Formatter = formatter;
        }

        public string Name { get; set; }
        public string Header { get; set; }
        public FormatFunc Formatter { get; set; }
    }
}
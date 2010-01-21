using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.Scaffold.Lists
{
    public class Row
    {
        public Guid Id { get; set; }
        public object[] Values { get; set; }
    }
}
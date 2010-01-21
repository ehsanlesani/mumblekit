using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Mumble.Web.StarterKit.Models.Scaffold.Mvc;

namespace Mumble.Web.StarterKit.Models.Scaffold.Lists
{
    public class ListControl : ViewUserControl
    {
        public ListConfiguration Configuration { get; set; }
        public List<Row> Data { get; set; }
        public string EditAction { get { return ((ScaffoldViewData)Model).EditAction; } }
        public string DeleteAction { get { return ((ScaffoldViewData)Model).DeleteAction; } }

    }
}
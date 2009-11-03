using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Mumble.Web.StarterKit.Models.Scaffold.Fields
{
    public class ZeroOrOneFieldControl : FieldControl
    {
        public ZeroOrOneFieldControl()
        {
            AddRequiredProperty("Items", typeof(SelectList));
        }

        public SelectList Items { get { return GetProperty<SelectList>("Items"); } }
    }
}
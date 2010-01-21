using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Mumble.Web.StarterKit.Models.Scaffold.Fields
{
    public class ManyFieldControl : FieldControl
    {
        public ManyFieldControl()
        {
            AddRequiredProperty("Items", typeof(SelectList));
        }

        public SelectList Items { get { return GetProperty<SelectList>("Items"); } }

        public List<string> Values
        {
            get
            {
                if (Value != null)
                    return new List<string>(Value.Split(','));

                return new List<string>();
            }
        }
    }
}
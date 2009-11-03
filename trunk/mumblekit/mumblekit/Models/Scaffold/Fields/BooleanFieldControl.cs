using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.Scaffold.Fields
{
    public class BooleanFieldControl : FieldControl
    {
        public string Checked
        {
            get
            {
                if (Value == null)
                    return "";

                return Boolean.Parse(Value) ? "checked='checked'" : "";
            }
        }
    }
}
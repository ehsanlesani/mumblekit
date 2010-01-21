using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models
{
    public partial class Section
    {
        public override string ToString()
        {
            return Description;
        }
    }
}
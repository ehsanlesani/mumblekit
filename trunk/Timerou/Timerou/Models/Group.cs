using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models
{
    public partial class Group
    {
        public override string ToString()
        {
            return Description;
        }
    }
}
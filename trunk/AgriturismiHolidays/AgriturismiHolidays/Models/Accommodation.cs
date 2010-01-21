using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models
{
    public partial class Accommodation : IEntityWithAttachments
    {
        public override string ToString()
        {
            return Name;
        }
    }
}
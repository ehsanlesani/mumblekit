using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.ExtPartial
{
    public partial class Accommodation : IEntityWithAttachments
    {
        public override string ToString()
        {
            return Name;
        }

        public string ShortDescription 
        {
            get 
            {
                if (Description.Length > 200)
                    return Description.Remove(197) +"...";
                else
                    return Description;
            }
        }
    }
}
﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models
{
    public partial class Attachment 
    {
        public override string ToString()
        {
            return Title +" "+ Description;
        }
    }
}
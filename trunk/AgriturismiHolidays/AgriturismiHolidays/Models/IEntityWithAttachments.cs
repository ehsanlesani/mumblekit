﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Objects.DataClasses;

namespace Mumble.Web.StarterKit.Models
{
    interface IEntityWithAttachments
    {
        EntityCollection<Attachment> Attachments { get; set; }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mumble.Web.StarterKit.Models.ExtPartial;

namespace Mumble.Web.StarterKit.Models.Scaffold.Fields.Custom
{
    public class AttachmentsFieldControl : FieldControl
    {
        public AttachmentsFieldControl()
        {
            AddRequiredProperty("Attachments", typeof(List<Attachment>));
        }

        public List<Attachment> Attachments { get; set; }
    }
}
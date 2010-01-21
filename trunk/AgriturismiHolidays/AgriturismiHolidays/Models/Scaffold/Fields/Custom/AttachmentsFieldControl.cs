using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

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
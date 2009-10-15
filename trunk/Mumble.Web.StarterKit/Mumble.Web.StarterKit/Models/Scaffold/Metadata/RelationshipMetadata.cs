using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Metadata.Edm;

namespace Mumble.Web.StarterKit.Models.Scaffold.Metadata
{
    public class RelationshipMetadata
    {
        public RelationInfo From { get; set; }
        public RelationInfo To { get; set; }
        public string EntitySet { get; set; }
        public string Name { get; set; }
    }
}
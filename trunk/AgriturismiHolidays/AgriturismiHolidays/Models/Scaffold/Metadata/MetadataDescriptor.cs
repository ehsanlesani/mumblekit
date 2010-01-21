using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.Scaffold.Metadata
{
    /// <summary>
    /// Represents entity metadata useful for Scaffolding
    /// </summary>
    public class MetadataDescriptor
    {
        public IEnumerable<FieldMetadata> Fields { get; set; }
        public IEnumerable<RelationshipMetadata> Relationships { get; set; }
        public string EntitySet { get; set; }
    }
}
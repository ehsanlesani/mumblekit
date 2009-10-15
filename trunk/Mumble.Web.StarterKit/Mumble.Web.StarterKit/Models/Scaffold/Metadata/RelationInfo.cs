using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Metadata.Edm;

namespace Mumble.Web.StarterKit.Models.Scaffold.Metadata
{
    /// <summary>
    /// Represents relationship element informations
    /// </summary>
    public class RelationInfo
    {
        public string MemberName { get; set; }
        public RelationshipMultiplicity RelationshipMultiplicity { get; set; }
    }
}
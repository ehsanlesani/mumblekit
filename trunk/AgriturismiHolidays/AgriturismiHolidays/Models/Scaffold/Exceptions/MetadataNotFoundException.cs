using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.Scaffold.Exceptions
{
    public class MetadataNotFoundException : Exception
    {
        public MetadataNotFoundException(Type entityType)
        {
            EntityType = entityType;
        }

        public Type EntityType { get; set; }
    }
}
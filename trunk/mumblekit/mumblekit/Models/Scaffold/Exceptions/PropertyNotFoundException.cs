using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.Scaffold.Exceptions
{
    /// <summary>
    /// The exception that is thrown when a property is not present in Scaffolded entity
    /// </summary>
    public class PropertyNotFoundException : Exception
    {
        public Type EntityType { get; set; }
        public string PropertyName { get; set; }

        public PropertyNotFoundException(Type entityType, string propertyName)
        {
            EntityType = entityType;
            PropertyName = propertyName;
        }
    }
}
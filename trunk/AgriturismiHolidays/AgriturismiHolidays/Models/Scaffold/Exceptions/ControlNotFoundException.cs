using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.Scaffold.Exceptions
{
    /// <summary>
    /// The exception that is thrown when a control type is not present in the controls map
    /// </summary>
    public class ControlNotFoundException : Exception
    {
        public Type EntityType { get; set; }
        public string PropertyName { get; set; }

        public ControlNotFoundException(Type entityType, string propertyName)
        {
            EntityType = entityType;
            PropertyName = propertyName;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel;
using Mumble.Web.StarterKit.Models.Scaffold.Fields;

namespace Mumble.Web.StarterKit.Models.Scaffold.Events
{
    /// <summary>
    /// Represent ControlCreate event data. The creation is cancelable
    /// </summary>
    public class ControlCreatedEventArgs : CancelEventArgs
    {
        public ControlCreatedEventArgs(Type entityType, string field, FieldControl createdControl)
        {
            EntityType = entityType;
            Field = field;
            CreatedControl = createdControl;
        }
        
        public Type EntityType { get; set; }
        public string Field { get; set; }
        public FieldControl CreatedControl { get; set; }
    }
}
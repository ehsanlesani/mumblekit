using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.Scaffold.Events
{
    /// <summary>
    /// Represents editing event data. Contains the edited entity ID or null if is a new entity
    /// </summary>
    public class BeforeEditEventArgs : EventArgs
    {
        public BeforeEditEventArgs(object entity)
        {
            Entity = entity;
        }

        public object Entity { get; set; }
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.Scaffold.Events
{
    /// <summary>
    /// Represents editing event data. Contains the edited entity
    /// </summary>
    public class BeforeUpdateEventArgs : EventArgs
    {
        public BeforeUpdateEventArgs(object entity)
        {
            Entity = entity;
        }

        public object Entity { get; set; }
    }
}
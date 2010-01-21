using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.Scaffold.Events
{
    /// <summary>
    /// Represents creating event data. Contains the newly created entity ID
    /// </summary>
    public class BeforeInsertEventArgs : EventArgs
    {
        public BeforeInsertEventArgs(object newEntity)
        {
            NewEntity = newEntity;
        }

        public object NewEntity { get; set; }
    }
}
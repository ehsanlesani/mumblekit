using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Mumble.Friendsheep.Models.Pool
{
    /// <summary>
    /// Provide functionality to raise server event to an ajax client
    /// </summary>
    public interface IRaisable
    {
        /// <summary>
        /// Gets event name
        /// </summary>
        string EventName { get; }

        /// <summary>
        /// Gets the raised event data
        /// </summary>
        object Data { get; }

        /// <summary>
        /// Check if current event is raised
        /// </summary>
        /// <returns></returns>
        bool Check();
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models.Exceptions
{
    /// <summary>
    /// The exception that is thrown when loading media fault
    /// </summary>
    public class MediaNotFoundException : Exception
    {
        public MediaNotFoundException(Guid mediaId)
        {
            MediaId = mediaId;
        }

        public Guid MediaId { get; set; }
    }
}

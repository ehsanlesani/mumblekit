using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models.Exceptions
{
    /// <summary>
    /// The exception that was thrown when an user try to save an unknown media type
    /// </summary>
    public class InvalidMediaTypeException : Exception
    {
        public string MediaType { get; private set; }

        public InvalidMediaTypeException(string mediaType)
        {
            MediaType = mediaType;
        }
    }
}

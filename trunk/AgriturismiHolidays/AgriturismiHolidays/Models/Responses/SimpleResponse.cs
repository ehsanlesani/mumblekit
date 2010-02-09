using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models
{
    /// <summary>
    /// Represents a simple response for ajax calls
    /// </summary>
    public class SimpleResponse
    {
        public SimpleResponse(bool error, string message)
        {
            Error = error;
            Message = message;
        }

        public bool Error { get; set; }
        public string Message { get; set; }
    }
}
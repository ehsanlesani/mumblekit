﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Friendsheep.Models.Responses
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
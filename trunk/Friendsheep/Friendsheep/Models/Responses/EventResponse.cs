using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Friendsheep.Models.Responses
{
    public class EventResponse : SimpleResponse
    {
        public EventResponse(bool error, bool timeout, string message, List<EventData> raisedEvents)
            : base(error, message)
        {
            Timeout = timeout;
            RaisedEvents = raisedEvents;
        }

        public bool Timeout { get; set; }
        public List<EventData> RaisedEvents { get; set; }
    }
}
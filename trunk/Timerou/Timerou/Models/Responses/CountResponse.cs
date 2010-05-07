using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models.Responses
{
    public class CountResponse : SimpleResponse
    {
        public CountResponse(bool error, string message, int count)
            :base(error, message)
        {
            Count = count;
        }

        public int Count { get; set; }
    }
}

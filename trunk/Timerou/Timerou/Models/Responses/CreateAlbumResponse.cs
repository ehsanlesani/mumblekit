using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models.Responses
{
    public class CreateAlbumResponse : SimpleResponse
    {
        public CreateAlbumResponse(bool error, string message, Guid id, string title)
            : base(error, message)
        {
            Id = id;
            Title = title;
        }

        public Guid Id { get; set; }
        public string Title { get; set; }
    }
}
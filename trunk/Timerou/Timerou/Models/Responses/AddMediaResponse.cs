using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models.Responses
{
    public class AddMediaResponse : SimpleResponse
    {
        public static AddMediaResponse FromPicture(Media media)
        {
            return new AddMediaResponse(false, "Media created")
            {
                Media = MediaData.FromMedia(media)
            };
        }
        
        public AddMediaResponse(bool error, string message)
            : base(error, message)
        {

        }

        public MediaData Media { get; set; }
    }
}
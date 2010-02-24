using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models.Responses
{
    public class LoadMediaResponse : SimpleResponse
    {
        public static LoadMediaResponse FromMedia(Media media)
        {
            LoadMediaResponse response = new LoadMediaResponse(false, "Media loaded")
            {
                Media = MediaData.FromMedia(media)
            };

            return response;
        }

        public LoadMediaResponse(bool error, string message)
            :base(error, message)
        { }

        public MediaData Media { get; set; }
    }
}

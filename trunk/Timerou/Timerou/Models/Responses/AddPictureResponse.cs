using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models.Responses
{
    public class AddPictureResponse : SimpleResponse
    {
        public static AddPictureResponse FromPicture(Picture picture)
        {
            return new AddPictureResponse(false, "Picture created")
            {
                Picture = PictureData.FromPicture(picture)
            };
        }
        
        public AddPictureResponse(bool error, string message)
            : base(error, message)
        {

        }

        public PictureData Picture { get; set; }
    }
}
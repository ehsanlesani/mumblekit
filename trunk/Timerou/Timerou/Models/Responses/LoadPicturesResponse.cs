using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models.Responses
{
    public class LoadPicturesResponse : SimpleResponse
    {
        public static LoadPicturesResponse FromList(IEnumerable<Picture> pictures)
        {
            LoadPicturesResponse response = new LoadPicturesResponse(false, "pictures loaded");
            foreach (var picture in pictures)
            {
                response.AddPicture(picture);
            }

            return response;
        }
        
        public List<PictureData> Pictures { get; set; }

        public LoadPicturesResponse(bool error, string message)
            : base(error, message)
        {
            Pictures = new List<PictureData>();
        }

        public void AddPicture(Picture picture)
        {
            Pictures.Add(PictureData.FromPicture(picture));
        }
    }
}
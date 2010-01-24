using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Friendsheep.Models.Responses
{
    public class LoadPicturesResponse : SimpleResponse
    {
       
        /// <summary>
        /// Create a response using album as source
        /// </summary>
        /// <param name="album"></param>
        /// <returns></returns>
        public static LoadPicturesResponse FromAlbum(Album album)
        {
            if (!album.Pictures.IsLoaded) { album.Pictures.Load(); }
            var response = new LoadPicturesResponse(false, "Pictures laoded");
            foreach (var picture in album.Pictures)
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
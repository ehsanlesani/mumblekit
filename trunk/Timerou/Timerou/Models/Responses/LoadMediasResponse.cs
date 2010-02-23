using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models.Responses
{
    public class LoadMediasResponse : SimpleResponse
    {
        public static LoadMediasResponse FromList(IEnumerable<Media> medias)
        {
            LoadMediasResponse response = new LoadMediasResponse(false, "medias loaded");
            foreach (var media in medias)
            {
                response.AddMedia(media);
            }

            return response;
        }

        public int TotalCount { get; set; }
        public List<MediaData> Medias { get; set; }

        public LoadMediasResponse(bool error, string message)
            : base(error, message)
        {
            Medias = new List<MediaData>();
        }

        public void AddMedia(Media media)
        {
            Medias.Add(MediaData.FromMedia(media));
        }
    }
}
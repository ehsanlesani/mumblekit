using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models.Responses
{
    public class MediaData
    {
        public static MediaData FromMedia(Media media)
        {
            var data = new MediaData()
            {
                Country = media.Country,
                Region = media.Region,
                City = media.City,
                Address = media.Address,
                Id = media.Id,
                Title = media.Title,
                Lat = media.Lat,
                Lng = media.Lng,
                Year = media.Year,
                Type = media.GetType().Name,
                Body = media.Body
            };

            if (media is Picture)
            {
                data.PictureData = PictureData.FromPicture((Picture)media);
            }
            else if (media is Video)
            {
                data.VideoData = VideoData.FromVideo((Video)media);
            }

            return data;
        }


        public PictureData PictureData { get; set; }
        public VideoData VideoData { get; set; }

        public Guid Id { get; set; }
        public String Title { get; set; }
        public String Country { get; set; }
        public String Region { get; set; }
        public String City { get; set; }
        public String Address { get; set; }
        public double Lat { get; set; }
        public double Lng { get; set; }
        public int Year { get; set; }
        public string Type { get; set; }
        public string Body { get; set; }
    }
}
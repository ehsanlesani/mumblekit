using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models.Responses
{
    public class PictureData
    {
        public static PictureData FromPicture(Picture picture)
        {
            return new PictureData()
            {
                AvatarPath = picture.AvatarPath,
                OptimizedPath = picture.OptimizedPath,
                OriginalPath = picture.OriginalPath,
                Country = picture.Country,
                Region = picture.Region,
                City = picture.City,
                Address = picture.Address,
                Id = picture.Id,
                Title = picture.Title,
                Lat = picture.Lat,
                Lng = picture.Lng,
                Year = picture.Year
            };
        }

        public Guid Id { get; set; }
        public String Title { get; set; }
        public String AvatarPath { get; set; }
        public String OptimizedPath { get; set; }
        public String OriginalPath { get; set; }
        public String Country { get; set; }
        public String Region { get; set; }
        public String City { get; set; }
        public String Address { get; set; }
        public double Lat { get; set; }
        public double Lng { get; set; }
        public int Year { get; set; }
    }
}
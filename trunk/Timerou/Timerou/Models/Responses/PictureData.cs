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
                Id = picture.Id
            };
        }

        public Guid Id { get; set; }
        public String Description { get; set; }
        public String AvatarPath { get; set; }
        public String OptimizedPath { get; set; }
        public float Vote { get; set; }
    }
}
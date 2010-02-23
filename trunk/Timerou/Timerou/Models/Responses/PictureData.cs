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
            PictureData data = new PictureData()
            {
                AvatarPath = picture.AvatarPath,
                OptimizedPath = picture.OptimizedPath,
                OriginalPath = picture.OriginalPath
            };

            return data;
        }

        public String AvatarPath { get; set; }
        public String OptimizedPath { get; set; }
        public String OriginalPath { get; set; }
    }
}

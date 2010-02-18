using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models.Responses
{
    /// <summary>
    /// Represents a response that contains pictures grouped by year
    /// </summary>
    public class YearGroupedPictureData
    {
        public static YearGroupedPictureData FromGroup(YearGroupedPictures pictures)
        {
            var response = new YearGroupedPictureData()
            {
                Year = pictures.Year
            };

            foreach (var pict in pictures.Pictures)
            {
                response.AddPicture(pict);
            }

            return response;
        }

        public YearGroupedPictureData()
        {
            Pictures = new List<PictureData>();
        }

        public int Year { get; set; }
        public List<PictureData> Pictures { get; set; }

        public void AddPicture(Picture picture)
        {
            Pictures.Add(PictureData.FromPicture(picture));
        }
    }
}

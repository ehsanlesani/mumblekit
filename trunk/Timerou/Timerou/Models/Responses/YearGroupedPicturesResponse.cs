using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models.Responses
{
    public class YearGroupedPicturesResponse : SimpleResponse
    {
        public static YearGroupedPicturesResponse FromList(IEnumerable<YearGroupedPictures> groupedPictures)
        {
            YearGroupedPicturesResponse response = new YearGroupedPicturesResponse(false, "pictures loaded");

            foreach (var gp in groupedPictures)
            {
                response.AddGroupedPictures(gp);
            }

            return response;
        }

        public YearGroupedPicturesResponse(bool error, string message)
            : base(error, message)
        {
            GroupedPictures = new List<YearGroupedPictureData>();
        }

        public List<YearGroupedPictureData> GroupedPictures { get; set; }

        public void AddGroupedPictures(YearGroupedPictures pictures)
        {
            GroupedPictures.Add(YearGroupedPictureData.FromGroup(pictures));
        }
    }
}

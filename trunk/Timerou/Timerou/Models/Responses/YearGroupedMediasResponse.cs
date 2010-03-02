using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models.Responses
{
    public class YearGroupedMediasResponse : SimpleResponse
    {
        public static YearGroupedMediasResponse FromList(IEnumerable<YearGroupedMedias> groupedMedias, bool light)
        {
            YearGroupedMediasResponse response = new YearGroupedMediasResponse(false, "medias loaded");

            foreach (var gp in groupedMedias)
            {
                response.AddGroupedPictures(gp, light);
            }

            return response;
        }

        public YearGroupedMediasResponse(bool error, string message)
            : base(error, message)
        {
            GroupedMedias = new List<YearGroupedMediasData>();
        }

        public List<YearGroupedMediasData> GroupedMedias { get; set; }

        public void AddGroupedPictures(YearGroupedMedias pictures, bool light)
        {
            GroupedMedias.Add(YearGroupedMediasData.FromGroup(pictures, light));
        }
    }
}

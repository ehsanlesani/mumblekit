using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models.Responses
{
    /// <summary>
    /// Represents a response that contains pictures grouped by year
    /// </summary>
    public class YearGroupedMediasData
    {
        public static YearGroupedMediasData FromGroup(YearGroupedMedias groupedMedias, bool light)
        {
            var response = new YearGroupedMediasData()
            {
                Year = groupedMedias.Year
            };

            foreach (var media in groupedMedias.Medias)
            {
                response.AddMedia(media, light);
            }

            return response;
        }

        public YearGroupedMediasData()
        {
            Medias = new List<MediaData>();
        }

        public int Year { get; set; }
        public List<MediaData> Medias { get; set; }

        public void AddMedia(Media media, bool light)
        {
            Medias.Add(MediaData.FromMedia(media, light));
        }
    }
}

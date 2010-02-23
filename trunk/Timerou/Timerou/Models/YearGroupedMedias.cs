using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models
{
    public class YearGroupedMedias
    {
        public int Year { get; set; }
        public IEnumerable<Media> Medias { get; set; }
    }
}

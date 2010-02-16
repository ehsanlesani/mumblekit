using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models
{
    public class YearGroupedPictures
    {
        public int Year { get; set; }
        public IEnumerable<Picture> Pictures { get; set; }
    }
}

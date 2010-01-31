using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models
{
    public class MapBounds
    {
        public MapBounds()
        {
            TopLeft = new LatLng();
            BottomRight = new LatLng();
        }

        public MapBounds(LatLng topLeft, LatLng bottomRight)
        {
            TopLeft = topLeft;
            BottomRight = bottomRight;
        }

        public LatLng TopLeft { get; set; }
        public LatLng BottomRight { get; set; }
    }
}

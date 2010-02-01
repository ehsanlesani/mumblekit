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

        /// <summary>
        /// Returns true if bounds cross meridian
        /// </summary>
        public bool CrossMeridian
        {
            get
            {
                return TopLeft.Lng > BottomRight.Lng;
            }
        }

        /// <summary>
        /// Move bounds to specified point
        /// </summary>
        /// <param name="point"></param>
        public void Move(LatLng point)
        {
            
        }

        public LatLng TopLeft { get; set; }
        public LatLng BottomRight { get; set; }
    }
}

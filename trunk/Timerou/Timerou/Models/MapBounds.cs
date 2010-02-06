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
        /// Creates a new instance of bounds width specified center and size
        /// </summary>
        /// <param name="center"></param>
        /// <param name="size"></param>
        /// <returns></returns>
        public static MapBounds CreateFromPoint(LatLng center, double size)
        {
            LatLng topLeft = new LatLng(center.Lat + size / 2.0, center.Lng - size / 2.0);
            LatLng bottomRight = new LatLng(center.Lat - size / 2.0, center.Lng + size / 2.0);

            return new MapBounds(topLeft, bottomRight);
        }

        /// <summary>
        /// Calculate bounds height. Lat on top is > than lat on bottom
        /// </summary>
        public double Height
        {
            get
            {
                return (TopLeft.Lat - BottomRight.Lat);
            }
        }

        /// <summary>
        /// Calculate bounds width
        /// </summary>
        public double Width
        {
            get
            {
                double width = 0d;
                if (CrossMeridian)
                {
                    width = 180 - TopLeft.Lng;
                    width += 180 - Math.Abs(BottomRight.Lng);
                }
                else
                {
                    width = BottomRight.Lng - TopLeft.Lng;
                }

                return width;
            }
        }

        /// <summary>
        /// Calculate bounds center
        /// </summary>
        public LatLng Center
        {
            get
            {
                double halfHeight = Height / 2d;
                double centerLat = TopLeft.Lat + halfHeight;

                double halfWidth = Width / 2;
                double centerLng = TopLeft.Lng + halfWidth;

                if (centerLng > 180) //Cross Meridian
                {
                    double delta = centerLng - 180;
                    centerLng = (180 - delta) * -1;
                }

                return new LatLng(centerLat, centerLng);
            }
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

        public LatLng TopLeft { get; set; }
        public LatLng BottomRight { get; set; }
    }
}

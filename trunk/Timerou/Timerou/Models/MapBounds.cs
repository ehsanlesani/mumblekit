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
        /// Calculate bounds height
        /// </summary>
        public double Height
        {
            get
            {
                return (BottomRight.Lat - TopLeft.Lat);
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

        /// <summary>
        /// Move bounds to specified point
        /// </summary>
        /// <param name="point"></param>
        public void Move(LatLng point)
        {
            var center = Center;

            
        }

        public LatLng TopLeft { get; set; }
        public LatLng BottomRight { get; set; }
    }
}

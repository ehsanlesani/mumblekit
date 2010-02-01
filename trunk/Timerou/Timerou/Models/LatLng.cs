using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models
{
    public class LatLng
    {
        public LatLng()
        {}

        public LatLng(double lat, double lng)
        {
            Lat = lat;
            Lng = lng;
        }

        public double Lat { get; set; }
        public double Lng { get; set; }
        
        /// <summary>
        /// Calculate distance from another latLng point
        /// </summary>
        /// <param name="other"></param>
        /// <returns></returns>
        public double Distance(LatLng other)
        {
            double radius = 6371.0d;
            double distance = Math.Acos(Math.Sin(this.Lat) * Math.Sin(other.Lat) +
                              Math.Cos(this.Lat) * Math.Cos(other.Lat) *
                              Math.Cos(other.Lng - this.Lng)) * radius;

            return distance;
        }
    }
}

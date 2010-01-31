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
    }
}

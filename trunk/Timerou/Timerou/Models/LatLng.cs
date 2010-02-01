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

        private double _lat = 0;
        private double _lng = 0;

        public LatLng(double lat, double lng)
        {
            Lat = lat;
            Lng = lng;
        }

        public double Lat {
            get
            {
                return _lat;
            }
            set
            {
                if (value > 90 || value < -90)
                {
                    throw new ArgumentException("Value must be between -90 and 90", "Lat");
                }

                _lat = value;
            }
        }

        public double Lng
        {
            get
            {
                return _lng;
            }
            set
            {
                if (value > 180 || value < -180)
                {
                    throw new ArgumentException("Value must be between -180 and 180", "Lng");
                }

                _lng = value;
            }
        }
        
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

        public override string ToString()
        {
            return String.Format("[Lat: {0}, Lng: {1}]", Lat, Lng);
        }
    }
}

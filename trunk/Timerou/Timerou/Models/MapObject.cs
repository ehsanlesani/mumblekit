using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models
{
    public partial class Media
    {
        public LatLng LatLng { get { return new LatLng(Lat, Lng); } }

        /// <summary>
        /// Gets distance in KM from another map object
        /// </summary>
        /// <param name="other"></param>
        /// <returns></returns>
        public double Distance(Media other) 
        {
            return LatLng.Distance(other.LatLng);
        }
    }
}

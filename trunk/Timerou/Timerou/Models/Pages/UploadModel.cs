using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Timerou.Models.Pages
{
    public class UploadModel
    {
        public UploadModel()
        {
            Lat = 40.6686534f;
            Lng = 16.6060872f;
            Zoom = 5;
            Year = DateTime.Now.Year;
        }

        public float Lat { get; set; }
        public float Lng { get; set; }
        public int Zoom { get; set; }
        public int Year { get; set; }
    }
}

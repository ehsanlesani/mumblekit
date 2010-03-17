﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mumble.Timerou.Models.ViewData;

namespace Mumble.Timerou.Models.Pages
{
    public class ShareModel : BaseModel
    {
        public ShareModel()
        {
            Lat = 40.6686534f;
            Lng = 16.6060872f;
            Zoom = 5;
            Year = DateTime.Now.Year;
        }

        public double Lat { get; set; }
        public double Lng { get; set; }
        public int Zoom { get; set; }
        public int Year { get; set; }
        public string MediaType { get; set; }

        [ModelValue]
        public Media Media { get; set; }
        [ModelValue]
        public Picture Picture { get { return Media as Picture; } }
        [ModelValue]
        public Video Video { get { return Media as Video; } }

    }
}

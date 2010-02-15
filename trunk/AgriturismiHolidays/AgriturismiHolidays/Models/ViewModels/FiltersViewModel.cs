using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mumble.Web.StarterKit.Models.ExtPartial;

namespace Mumble.Web.StarterKit.Models.ViewModels
{
    public class FiltersViewModel : CustomViewModel
    {
        public IQueryable<Region> Regions { get; set; }
        public IQueryable<Province> Provinces { get; set; }
        public IQueryable<Municipality> Municipalities { get; set; }
    }
}

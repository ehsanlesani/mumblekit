using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mumble.Web.StarterKit.Models.ExtPartial;

namespace Mumble.Web.StarterKit.Models.ViewModels
{
    public class StructureListViewModel
    {
        public IEnumerable<Accommodation> Accommodations { get; set; }
        public string SectionName { get; set; }

        public StructureListViewModel(IEnumerable<Accommodation> accommodations) 
        {
            Accommodations = accommodations;
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mumble.Web.StarterKit.Models.ExtPartial;

namespace Mumble.Web.StarterKit.Models.ViewModels
{
    public class StructureViewModel : CustomViewModel
    {
        public Accommodation Accommodation { get; set; }

        public StructureViewModel(Accommodation accommodation) 
        {
            Accommodation = accommodation;
        }

        public StructureViewModel() { }
    }
}

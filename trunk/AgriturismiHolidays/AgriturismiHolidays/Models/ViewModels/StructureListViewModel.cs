﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mumble.Web.StarterKit.Models.ExtPartial;

namespace Mumble.Web.StarterKit.Models.ViewModels
{
    public class StructureListViewModel : CustomViewModel
    {
        public IEnumerable<Accommodation> Accommodations { get; set; }
        public IEnumerable<Page> StaticPages { get; set; }
        public string SectionName { get; set; }
        public int Pages { get; set; }
        public int ItemsPerPage { get; set; }
        public int ActualPage { get; set; }

        public StructureListViewModel(IEnumerable<Accommodation> accommodations) 
        {
            Accommodations = accommodations;
        }

        public StructureListViewModel(IEnumerable<Accommodation> accommodations, IEnumerable<Page> pages)
        {
            Accommodations = accommodations;
            StaticPages = pages;
        }

        public StructureListViewModel() { }
    }
}

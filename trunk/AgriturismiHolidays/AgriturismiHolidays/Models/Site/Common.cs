﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mumble.Web.StarterKit.Models.ExtPartial;
using System.Web.Mvc;
using Mumble.Web.StarterKit.Models.Common;

namespace Mumble.Web.StarterKit.Models.Site
{
    public static class Common
    {
        public static IEnumerable<SelectListItem> GetAccommodationTypeList()
        {
            StarterKitContainer context = new StarterKitContainer();
            var atypes = (from a in context.AccommodationTypes orderby a.Name select a);

            IList<SelectListItem> items = new List<SelectListItem>();

            SelectListItem empty = new SelectListItem();
            empty.Text = " - tipologia - ";
            items.Add(empty);

            foreach (AccommodationType a in atypes)
            {
                SelectListItem s = new SelectListItem();
                s.Text = a.Name;
                s.Value = a.Name.Replace(" ", "_");
                items.Add(s);
            }

            return items;
        }

        public static IEnumerable<SelectListItem> GetAccommodationTypes(Guid? selectedId)
        {
            StarterKitContainer context = new StarterKitContainer();
            var atypes = (from a in context.AccommodationTypes orderby a.Name select a);

            IList<SelectListItem> items = new List<SelectListItem>();

            
            SelectListItem empty = new SelectListItem();
            empty.Text = " - tipologia - ";
            if (!selectedId.HasValue)
                empty.Selected = true;

            items.Add(empty);

            foreach (AccommodationType a in atypes)
            {
                SelectListItem s = new SelectListItem();
                s.Text = a.Name;
                s.Value = a.Id.ToString();

                if (selectedId.HasValue)
                    if (a.Id == selectedId)
                        s.Selected = true;

                items.Add(s);
            }

            return items;
        }

        public static IEnumerable<SelectListItem> GetRegionsSelectList(Guid? id)
        {
            StarterKitContainer context = new StarterKitContainer();
            var regions = LocalityHelper.GetRegions();
            IList<SelectListItem> items = new List<SelectListItem>();

            SelectListItem empty = new SelectListItem();
            empty.Text = " - regione - ";
            if (!id.HasValue)
                empty.Selected = true;

            items.Add(empty);

            foreach (JsonSelection r in regions)
            {
                SelectListItem s = new SelectListItem();
                s.Text = r.Value;
                s.Value = r.Id.ToString();
                if (r.Id == id)
                    s.Selected = true;
                
                items.Add(s);
            }
                        
            return items;
        }

        public static IEnumerable<SelectListItem> GetProvincesSelectList(Guid? id, Guid regionId)
        {
            StarterKitContainer context = new StarterKitContainer();
            var regions = LocalityHelper.GetProvinces(regionId);
            IList<SelectListItem> items = new List<SelectListItem>();

            SelectListItem empty = new SelectListItem();
            empty.Text = " - provincia - ";
            if (!id.HasValue)
                empty.Selected = true;

            items.Add(empty);

            foreach (JsonSelection r in regions)
            {
                SelectListItem s = new SelectListItem();
                s.Text = r.Value;
                s.Value = r.Id.ToString();
                if (r.Id == id)
                    s.Selected = true;

                items.Add(s);
            }

            return items;
        }

        public static IEnumerable<SelectListItem> GetMunicipalitiesSelectList(Guid? id, Guid provinceId)
        {
            StarterKitContainer context = new StarterKitContainer();
            var regions = LocalityHelper.GetMunicipalities(provinceId);
            IList<SelectListItem> items = new List<SelectListItem>();

            SelectListItem empty = new SelectListItem();
            empty.Text = " - comune - ";
            if (!id.HasValue)
                empty.Selected = true;

            items.Add(empty);

            foreach (JsonSelection r in regions)
            {
                SelectListItem s = new SelectListItem();
                s.Text = r.Value;
                s.Value = r.Id.ToString();
                if (r.Id == id)
                    s.Selected = true;

                items.Add(s);
            }

            return items;
        }
    }
}

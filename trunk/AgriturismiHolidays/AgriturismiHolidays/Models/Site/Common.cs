using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mumble.Web.StarterKit.Models.ExtPartial;
using System.Web.Mvc;

namespace Mumble.Web.StarterKit.Models.Site
{
    public static class Common
    {
        public static IEnumerable<SelectListItem> GetAccommodationTypeList()
        {
            StarterKitContainer context = new StarterKitContainer();
            var atypes = (from a in context.AccommodationTypes orderby a.Name select a);

            IList<SelectListItem> items = new List<SelectListItem>();
            foreach (AccommodationType a in atypes)
            {
                SelectListItem s = new SelectListItem();
                s.Text = a.Name;
                s.Value = a.Name.Replace(" ", "_");
                items.Add(s);
            }

            return items;
        }

        public static IEnumerable<SelectListItem> GetRegionsSelectList()
        {
            StarterKitContainer context = new StarterKitContainer();
            var regions = (from r in context.Regions orderby r.Description select r);
            IList<SelectListItem> items = new List<SelectListItem>();
            foreach (Region r in regions)
            {
                SelectListItem s = new SelectListItem();
                s.Text = r.Description;
                s.Value = r.Id.ToString();
                items.Add(s);
            }

            return items;
        }
    }
}

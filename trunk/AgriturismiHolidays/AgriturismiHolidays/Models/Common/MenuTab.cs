using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;
using Mumble.Web.StarterKit.Models.ExtPartial;

namespace Mumble.Web.StarterKit.Models.Common
{
    public class MenuTab
    {
        public string Text { get; private set; }
        public string Action { get; private set; }
        public string Controller { get; private set; }
        public string Category { get; private set; }

        private MenuTab(string text, string action, string controller, string category)
        {
            Text = text;
            Action = action;
            Controller = controller;
            Category = category;
        }

        public static MenuTab Create(string text, string action, string controller, string category)
        {
            return new MenuTab(text, action, controller, category);
        }

        public static IEnumerable<MenuTab> GetMenuItems()
        {
            StarterKitContainer context = new StarterKitContainer();
            var items = (from i in context.AccommodationTypes orderby i.Priority select i);

            IList<MenuTab> listitems = new List<MenuTab>();
            foreach (AccommodationType a in items)
            {
                MenuTab li = new MenuTab(a.Name, "List", "Structure", a.Name.Replace(" ", "_"));               
                listitems.Add(li);
            }

            return listitems.AsEnumerable<MenuTab>();
        }

        public static IEnumerable<MenuTab> GetGlobalPages()
        {
            StarterKitContainer context = new StarterKitContainer();
            var items = (from p in context.Pages where 
                             p.Sections.Description == "global" && 
                             p.Visible.Value &&
                             (((p.ValidFrom.HasValue && DateTime.Now >= p.ValidFrom)
                              && (p.ValidTo.HasValue && DateTime.Now <= p.ValidTo)) ||
                               (p.ValidFrom.HasValue && DateTime.Now >= p.ValidFrom))
                         orderby p.Priority ascending 
                         select p);

            IList<MenuTab> listitems = new List<MenuTab>();
            foreach (Page p in items)
            {
                MenuTab li = new MenuTab(p.Description, "List", "Page", p.Description.Replace(" ", "_"));
                listitems.Add(li);
            }

            return listitems.AsEnumerable<MenuTab>();
        }
    }
}

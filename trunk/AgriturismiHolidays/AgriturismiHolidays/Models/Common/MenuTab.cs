using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI.WebControls;

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
            var items = (from i in context.AccommodationTypes orderby i.Name select i);

            IList<MenuTab> listitems = new List<MenuTab>();
            foreach (AccommodationType a in items)
            {
                MenuTab li = new MenuTab(a.Name, "List", "Structure", a.Name.Replace(" ", "_"));               
                listitems.Add(li);
            }

            return listitems.AsEnumerable<MenuTab>();
        }
    }
}

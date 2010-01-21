using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Mumble.Web.StarterKit.Models.Common;
using System.Web.Mvc;

namespace Mumble.Web.StarterKit.Views.Utilities.Helpers
{
    public static class MenuHelper
    {
        public static string TabbedMenu(this HtmlHelper helper, IEnumerable<MenuTab> tabs)
        {
            if (tabs == null)
                return "";

            var urlHelper = new UrlHelper(helper.ViewContext.RequestContext);
            var route = helper.ViewContext.RequestContext.RouteData;
            var controller = route.GetRequiredString("controller");
            var action = route.GetRequiredString("action");
            var menu = "";

            foreach (var tab in tabs)
            {
                string url = urlHelper.RouteUrl("Structures", new { action = tab.Action, controller = tab.Controller, category = tab.Category });
                string cssClassName = "";

                if (controller == tab.Controller && 
                    action == tab.Action)
                    cssClassName = "selected";

                menu += "\n\t<li><a href=\"" + url + "\" class=\""+ cssClassName +"\">" + tab.Text + "</a></li>";              
            }

            return menu;
        }
    }
}

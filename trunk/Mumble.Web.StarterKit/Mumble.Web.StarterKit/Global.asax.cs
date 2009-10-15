using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

using Mumble.Web.StarterKit.Models.Scaffold.Lists;
using Mumble.Web.StarterKit.Models;
using Mumble.Web.StarterKit.Models.Scaffold.Fields;
using Mumble.Web.StarterKit.Models.Scaffold.Converters.Custom;

namespace MumbleKit
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                "Admin",                                                
                "Admin/{controller}/{action}/{id}",                     
                new { controller = "Home", action = "Index", id = "" },
                new string[] { "Mumble.Web.StarterKit.Controllers.Admin" }
            );

            routes.MapRoute(
                "Site",                                              
                "{controller}/{action}/{id}",                           
                new { controller = "Home", action = "Index", id = "" },
                new string[] { "Mumble.Web.StarterKit.Controllers.Site" }
            );

            routes.MapRoute(
                "Default",
                "",
                new { controller = "Home", action = "Index" },
                new string[] { "Mumble.Web.StarterKit.Controllers.Site" }
            );

        }

        private void SetupScaffolding()
        {
            ListConfiguration configuration = new ListConfiguration();
            configuration.AddColumn("Id", "Id");
            configuration.AddColumn("Description", "Description");
            configuration.AddColumn("Visible", "Visibility", o => ((bool)o) ? "Visible" : "Not visible");

            ListManager.Instance.RegisterConfiguration(typeof(Page), configuration);
            ListManager.Instance.RegisterConfiguration(typeof(Section), configuration);

            FieldBuilder.Instance.SetControl(typeof(Page), "Attachments", "Custom/Attachments.ascx", null, new AttachmentsConverter());
            FieldBuilder.Instance.SetControl(typeof(Page), "Body", "Custom/Html.ascx", null, null);
        }

        protected void Application_Start()
        {
            RegisterRoutes(RouteTable.Routes);
            SetupScaffolding();
        }
    }
}
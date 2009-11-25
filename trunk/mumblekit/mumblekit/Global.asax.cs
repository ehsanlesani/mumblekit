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
using System.Data.Metadata.Edm;

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
                new { controller = "Main", action = "Index", id = "" },
                new string[] { "Mumble.Web.StarterKit.Controllers.Admin" }
            );

            routes.MapRoute(
                "Site",                                              
                "Site/{controller}/{action}/{id}",                           
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
            ListConfiguration pageConfiguration = new ListConfiguration();
            pageConfiguration.AddColumn("Description", "Description");
            pageConfiguration.AddColumn("Visible", "Visibility", o => ((bool)o) ? "Visible" : "Not visible");

            ListConfiguration userConfiguration = new ListConfiguration();
            userConfiguration.AddColumn("FirstName", "Nome");
            userConfiguration.AddColumn("LastName", "Cognome");
            userConfiguration.AddColumn("Email", "Email", o => String.Format("<a href='mailto:{0}'>{0}</a>", o));

            ListConfiguration groupConfiguration = new ListConfiguration();
            groupConfiguration.AddColumn("Description", "Descrizione");

            ListManager.Instance.RegisterConfiguration(typeof(Page), pageConfiguration);
            ListManager.Instance.RegisterConfiguration(typeof(Section), pageConfiguration);
            ListManager.Instance.RegisterConfiguration(typeof(User), userConfiguration);
            ListManager.Instance.RegisterConfiguration(typeof(Group), groupConfiguration);

            FieldBuilder.Instance.SetControl(typeof(IEnumerable<Attachment>), RelationshipMultiplicity.Many, "Custom/Attachments.ascx", null, new AttachmentsConverter());
            FieldBuilder.Instance.SetControl(typeof(Page), "Body", "Custom/Html.ascx", null, null);
        }

        protected void Application_Start()
        {
            RegisterRoutes(RouteTable.Routes);
            SetupScaffolding();
        }
    }
}
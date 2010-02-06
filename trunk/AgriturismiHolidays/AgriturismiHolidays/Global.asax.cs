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
using System.Text;
using System.Data.Objects.DataClasses;
using Mumble.Web.StarterKit.Models.ExtPartial;

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
                "Default",
                "",
                new { controller = "Home", action = "Index" },
                new string[] { "Mumble.Web.StarterKit.Controllers.Site" }
            );

            routes.MapRoute(
                "Site",
                "{controller}.aspx/{action}",
                new { controller = "Home", action = "Index", id = "" },
                new string[] { "Mumble.Web.StarterKit.Controllers.Site" }
            );

            routes.MapRoute(
                "Structures",
                "{controller}.aspx/{action}/{id}",
                new { controller = "Structures", action = "Index", id = "" },
                new string[] { "Mumble.Web.StarterKit.Controllers.Site" }
            );

            routes.MapRoute(
                "Admin",
                "Admin/{controller}.aspx/{action}/{id}",
                new { controller = "Main", action = "Index", id = "" },
                new string[] { "Mumble.Web.StarterKit.Controllers.Admin" }
            );
            
            routes.MapRoute(
                "AdminDefault",
                "Admin/",
                new { controller = "Main", action = "Index" },
                new string[] { "Mumble.Web.StarterKit.Controllers.Admin" }
            );

            /*
            routes.MapRoute(
                "Structures",
                "{controller}.aspx/{action}/{category}",
                new { controller = "Structure", action = "Index", category = "" },
                new string[] { "Mumble.Web.StarterKit.Controllers.Site" }
            );
            */
            
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

            ListConfiguration roomConfiguration = new ListConfiguration();
            roomConfiguration.AddColumn("Name", "Nome");
            roomConfiguration.AddColumn("Text", "Testo");
            roomConfiguration.AddColumn("Persons", "Posti");
            roomConfiguration.AddColumn("Accommodations", "Struttura");
            roomConfiguration.AddColumn("RoomPriceList", "Prezzo", o =>
            {
                StringBuilder b = new StringBuilder();
                var list = (IEnumerable<RoomPriceList>)o;
                foreach (var price in list)
                {
                    b.Append(price.Price.GetValueOrDefault().ToString("0.00€ - "));
                }


                return b.ToString().Remove(b.Length - 3, 3);
            });

            ListConfiguration accommodationConfiguration = new ListConfiguration();
            accommodationConfiguration.AddColumn("Name", "Nome");
            accommodationConfiguration.AddColumn("Description", "Descrizione");
            accommodationConfiguration.AddColumn("Street", "Ind.");
            accommodationConfiguration.AddColumn("StreetNr", "Ind.Nr");
            accommodationConfiguration.AddColumn("Cap", "Cap");
            accommodationConfiguration.AddColumn("ShowMap", "Mappa");
            accommodationConfiguration.AddColumn("WhereWeAre", "Dove");
            accommodationConfiguration.AddColumn("Email", "Mail");
            accommodationConfiguration.AddColumn("Tel", "Tel");
            accommodationConfiguration.AddColumn("Fax", "Fax");
            accommodationConfiguration.AddColumn("OnShowcase", "Consigliata");
            accommodationConfiguration.AddColumn("Quality", "Stelle");
            accommodationConfiguration.AddColumn("AccommodationType", "Tipologia");
            accommodationConfiguration.AddColumn("Attachments", "Foto", Formatters.EnumerationFormatter);
            accommodationConfiguration.AddColumn("Rooms", "Sistemazione", Formatters.EnumerationFormatter);
            accommodationConfiguration.AddColumn("Municipalities", "Provincia");

            ListConfiguration priceListConfiguration = new ListConfiguration();
            priceListConfiguration.AddColumn("Description", "Descrizione");
            priceListConfiguration.AddColumn("RoomPriceList", "Prezzo", o =>
            {
                StringBuilder b = new StringBuilder();
                var list = (IEnumerable<RoomPriceList>)o;
                foreach (var price in list)
                {
                    b.Append(price.Price.GetValueOrDefault().ToString("0.00€ - "));
                }
                
                return b.ToString();
            });

            ListConfiguration priceListSeasonConfiguration = new ListConfiguration();
            priceListSeasonConfiguration.AddColumn("PeriodStart", "Inizio");
            priceListSeasonConfiguration.AddColumn("PeriodEnd", "Fine");
            priceListSeasonConfiguration.AddColumn("Description", "Descrizione");
            priceListSeasonConfiguration.AddColumn("RoomPriceList", "Prezzo", o =>
            {
                StringBuilder b = new StringBuilder();
                var list = (IEnumerable<RoomPriceList>)o;
                foreach (var price in list)
                {
                    b.Append(price.Price.GetValueOrDefault().ToString("0.00€ - "));
                }
                
                return b.ToString().Remove(b.Length - 3, 3);
            });

            ListConfiguration roomPriceListConfiguration = new ListConfiguration();
            roomPriceListConfiguration.AddColumn("Rooms", "Sistemazione");
            roomPriceListConfiguration.AddColumn("PriceListSeasons", "Stagione");
            roomPriceListConfiguration.AddColumn("PriceListEntries", "Tipologia");
            roomPriceListConfiguration.AddColumn("Price", "Prezzo", o =>
            {
                var value = (Decimal)o;
                return value.ToString("0.00€");
            });

            ListManager.Instance.RegisterConfiguration(typeof(Page), pageConfiguration);
            ListManager.Instance.RegisterConfiguration(typeof(Section), pageConfiguration);
            ListManager.Instance.RegisterConfiguration(typeof(User), userConfiguration);
            ListManager.Instance.RegisterConfiguration(typeof(Group), groupConfiguration);
            ListManager.Instance.RegisterConfiguration(typeof(Room), roomConfiguration);
            ListManager.Instance.RegisterConfiguration(typeof(Accommodation), accommodationConfiguration);
            ListManager.Instance.RegisterConfiguration(typeof(PriceListEntry), priceListConfiguration);
            ListManager.Instance.RegisterConfiguration(typeof(PriceListSeason), priceListSeasonConfiguration);
            ListManager.Instance.RegisterConfiguration(typeof(RoomPriceList), roomPriceListConfiguration);

            FieldBuilder.Instance.SetControl(typeof(IEnumerable<Attachment>), RelationshipMultiplicity.Many, "Custom/Attachments.ascx", null, new AttachmentsConverter());
            FieldBuilder.Instance.SetControl(typeof(Page), "Body", "Custom/Html.ascx", null, null);
            FieldBuilder.Instance.SetControl(typeof(Room), "Text", "Custom/Textarea.ascx", null, null);
            FieldBuilder.Instance.SetControl(typeof(Object), "Description", "Custom/Html.ascx", null, null);
        }

        protected void Application_Start()
        {
            RegisterRoutes(RouteTable.Routes);
            SetupScaffolding();
        }
    }
}
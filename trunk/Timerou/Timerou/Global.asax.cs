﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using Mumble.Timerou.Models.Helpers;

namespace Mumble.Timerou
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                "Main",                                                 // Route name
                "",                                                    // URL with parameters
                new { controller = "Main", action = "Index", id = "" }  // Parameter defaults
            );

            routes.MapRoute(
                "Site",                                                 // Route name
                "{controller}.aspx/{action}/{id}",                      // URL with parameters
                new { controller = "Main", action = "Index", id = "" }  // Parameter defaults
            );
        }

        protected void Application_Start()
        {
            RegisterRoutes(RouteTable.Routes);
        }

        protected void Session_Start()
        {
            UIHelper.ChangeCulture(UIHelper.DefaultCulture);
        }

        protected void Application_Error()
        {
            Application["LastError"] = Server.GetLastError();
        }
    }
}
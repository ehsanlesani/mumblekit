using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;

namespace Mumble.Friendsheep.Models.Helpers
{
    /// <summary>
    /// Contains all path for html (not for server filesystem)
    /// </summary>
    public class UriHelper
    {
        /// <summary>
        /// Gets base application url
        /// </summary>
        public static string Base
        {
            get
            {
                return HttpContext.Current.Request.ApplicationPath;
            }
        }

        /// <summary>
        /// Gets base images uri
        /// </summary>
        public static string Images
        {
            get
            {
                return HttpContext.Current.Request.ApplicationPath + "Content/Images/";
            }
        }

        /// <summary>
        /// Gets base scripts uri
        /// </summary>
        public static string Scripts
        {
            get
            {
                return HttpContext.Current.Request.ApplicationPath + "Scripts/";
            }
        }

        /// <summary>
        /// Gets base scripts uri
        /// </summary>
        public static string Css
        {
            get
            {
                return HttpContext.Current.Request.ApplicationPath + "Content/Css/";
            }
        }

        /// <summary>
        /// Gets base pictures uri
        /// </summary>
        public static string Pictures
        {
            get
            {
                return HttpContext.Current.Request.ApplicationPath + ConfigurationManager.AppSettings["BasePicturesPath"] + "/";
            }
        }
    }
}
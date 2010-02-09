using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Newtonsoft.Json;
using Newtonsoft.Json.Serialization;

namespace Mumble.Web.StarterKit.Models
{
    public static class ControllerExtension
    {
        /// <summary>
        /// Create json action result from specified data in camel case notation
        /// </summary>
        /// <param name="controller"></param>
        /// <param name="data"></param>
        /// <returns></returns>
        public static ActionResult CamelCaseJson(this Controller controller, object data)
        {
            string json = JsonConvert.SerializeObject(data, Formatting.Indented, new JsonSerializerSettings() { ContractResolver = new CamelCasePropertyNamesContractResolver() });
            return new ContentResult() { Content = json, ContentType = "application/json" };
        }

    }
}
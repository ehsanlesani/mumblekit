﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Mumble.Web.StarterKit.Models.ExtPartial;
using Newtonsoft.Json;
using Mumble.Web.StarterKit.Models.Common;

namespace Mumble.Web.StarterKit.Controllers.Site
{
    public class SelectValuesController : Controller
    {
        StarterKitContainer _container = null;

        public SelectValuesController() 
        {
            _container = new StarterKitContainer();
        }

        public ActionResult Regions()
        {
            var regions = LocalityHelper.GetRegions();
            return Json(regions);
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Provinces(Guid? id)
        {
            var province = LocalityHelper.GetProvinces(id.Value);
            return Json(province);
        }

        [AcceptVerbs(HttpVerbs.Get)]
        public ActionResult Municipalities(Guid? id)
        {
            var municipality = LocalityHelper.GetMunicipalities(id.Value);
            return Json(municipality);
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using Mumble.Web.StarterKit.Models;
using System.Data.Objects;
using Mumble.Web.StarterKit.Models.Scaffold.Mvc;

namespace Mumble.Web.StarterKit.Controllers.Admin
{
    public class AccommodationTypeController : ScaffoldController<AccommodationType>
    {
        private StarterKitContainer _objectContext = new StarterKitContainer();
        protected override ObjectContext ObjectContext { get { return _objectContext; } }
    }
}
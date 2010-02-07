using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using Mumble.Web.StarterKit.Models;
using Mumble.Web.StarterKit.Models.Scaffold.Mvc;
using Mumble.Web.StarterKit.Models.ExtPartial;

namespace Mumble.Web.StarterKit.Controllers.Admin
{
    public class ServiceController : ScaffoldController<Service>
    {
        protected override System.Data.Objects.ObjectContext ObjectContext
        {
            get { return new StarterKitContainer(); }
        }
    }
}

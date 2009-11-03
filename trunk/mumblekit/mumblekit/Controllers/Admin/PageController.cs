using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Mvc.Ajax;
using Mumble.Web.StarterKit.Models;
using Mumble.Web.StarterKit.Models.Scaffold.Mvc;
using Mumble.Web.StarterKit.Models.Scaffold.Fields;
using Mumble.Web.StarterKit.Models.Scaffold.Lists;
using Mumble.Web.StarterKit.Models.Scaffold.Converters.Custom;
using System.Data.Objects;

namespace Mumble.Web.StarterKit.Controllers.Admin
{
    public class PageController : ScaffoldController<Page>
    {
        private StarterKitContainer _objectContext = new StarterKitContainer();
        protected override ObjectContext ObjectContext { get { return _objectContext; } }
    }
}

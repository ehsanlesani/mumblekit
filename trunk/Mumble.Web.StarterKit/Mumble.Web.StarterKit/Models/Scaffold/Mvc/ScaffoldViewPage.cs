using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Mumble.Web.StarterKit.Models.Scaffold.Mvc
{
    public class ScaffoldViewPage : ViewPage<ScaffoldViewData>
    {
        public Scaffolder Scaffolder { get { return Model.Scaffolder; } }
        public Type EntityType { get { return Model.EntityType; } }
        public Guid? Id { get { return Model.Id; } }
    }
}
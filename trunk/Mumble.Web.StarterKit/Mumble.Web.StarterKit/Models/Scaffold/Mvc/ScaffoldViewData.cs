using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.Scaffold.Mvc
{
    public class ScaffoldViewData
    {
        public Scaffolder Scaffolder { get; set; }
        public Type EntityType { get; set; }
        public Guid? Id { get; set; }
        public string SaveAction { get; set; }
        public string ListAction { get; set; }
        public string EditAction { get; set; }
        public string DeleteAction { get; set; }
    }
}
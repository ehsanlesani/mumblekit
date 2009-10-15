using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Mumble.Web.StarterKit.Models.Scaffold.Fields.Config
{
    /// <summary>
    /// Represent properties injector for field when no one is specified
    /// </summary>
    public class StandardFieldPropertiesInjector : IPropertiesInjector
    {
        public void Inject(FieldControl fieldControl, Scaffolder Scaffolder)
        {
            //nothing to do now
        }
    }
}
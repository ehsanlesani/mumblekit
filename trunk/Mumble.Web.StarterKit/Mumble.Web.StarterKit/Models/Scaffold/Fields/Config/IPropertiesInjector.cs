using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Mumble.Web.StarterKit.Models.Scaffold.Fields.Config
{
    /// <summary>
    /// Define the methods to inject additional properties in a control
    /// </summary>
    public interface IPropertiesInjector
    {
        /// <summary>
        /// Inject additional properties in a control
        /// </summary>
        /// <param name="fieldControl">Control to inject properties</param>
        /// <param name="Scaffolder">Scaffold context instance</param>
        void Inject(FieldControl fieldControl, Scaffolder Scaffolder);
    }
}

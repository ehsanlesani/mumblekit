using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Metadata.Edm;
using Mumble.Web.StarterKit.Models.Scaffold.Converters;

namespace Mumble.Web.StarterKit.Models.Scaffold.Fields
{
    /// <summary>
    /// Represent a Type -> Control map
    /// </summary>
    public class ControlsMap : List<ControlReference>
    {
        /// <summary>
        /// Create the default control map for standard types. The priority is the index in list
        /// </summary>
        /// <returns></returns>
        public static ControlsMap CreateDefault()
        {
            ControlsMap map = new ControlsMap();

            //standard
            map.Add(new ControlReference(typeof(DateTime), "DateTime.ascx", null, new DateTimeConverter()));
            map.Add(new ControlReference(typeof(DateTime?), "DateTime.ascx", null, new DateTimeConverter()));
            map.Add(new ControlReference(typeof(Int32), "Int32.ascx", null, new Int32Converter()));
            map.Add(new ControlReference(typeof(Int32?), "Int32.ascx", null, new Int32Converter()));
            map.Add(new ControlReference(typeof(Boolean), "Boolean.ascx", null, new BooleanConverter()));
            map.Add(new ControlReference(typeof(Boolean?), "Boolean.ascx", null, new BooleanConverter()));
            map.Add(new ControlReference(typeof(Guid), "Guid.ascx", null, new GuidConverter()));
            map.Add(new ControlReference(typeof(Object), "String.ascx", null, new StringConverter()));
         
            //references
            map.Add(new ControlReference(typeof(Object), RelationshipMultiplicity.Many, "Many.ascx", null, new ManyRelationshipConverter()));
            map.Add(new ControlReference(typeof(Object), RelationshipMultiplicity.One, "ZeroOrOne.ascx", null, new OneRelationshipConverter()));
            map.Add(new ControlReference(typeof(Object), RelationshipMultiplicity.ZeroOrOne, "ZeroOrOne.ascx", null, new OneRelationshipConverter()));

            return map;
        }
    }
}
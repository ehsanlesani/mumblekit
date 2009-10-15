using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Metadata.Edm;
using Mumble.Web.StarterKit.Models.Scaffold.Fields.Config;
using Mumble.Web.StarterKit.Models.Scaffold.Converters;

namespace Mumble.Web.StarterKit.Models.Scaffold.Fields
{
    /// <summary>
    /// Represent a control reference for the property Type
    /// </summary>
    public class ControlReference
    {
        /// <summary>
        /// Construct a control reference for standard properties
        /// </summary>
        /// <param name="propertyType"></param>
        /// <param name="control"></param>
        /// <param name="propertiesInjector"></param>
        /// <param name="converter"></param>
        public ControlReference(Type propertyType, string control, IPropertiesInjector propertiesInjector, IValueConverter converter)
        {
            PropertyType = propertyType;
            Control = control;
            IsRelationship = false;
            IsSpecific = false;
            PropertiesInjector = propertiesInjector;
            Converter = converter;
        }
        
        /// <summary>
        /// Construct a control reference for relationed properties
        /// </summary>
        /// <param name="propertyType"></param>
        /// <param name="relationshipMultiplicity"></param>
        /// <param name="control"></param>
        /// <param name="propertiesInjector"></param>
        /// <param name="converter"></param>
        public ControlReference(Type propertyType, RelationshipMultiplicity relationshipMultiplicity, string control, IPropertiesInjector propertiesInjector, IValueConverter converter)
        {
            PropertyType = propertyType;
            Control = control;
            IsRelationship = true;
            IsSpecific = false;
            RelationshipMultiplicity = relationshipMultiplicity;
            PropertiesInjector = propertiesInjector;
        }

        /// <summary>
        /// Construct a control reference for a specified property of specified entity
        /// </summary>
        /// <param name="entityType"></param>
        /// <param name="propertyName"></param>
        /// <param name="control"></param>
        /// <param name="propertiesInjector"></param>
        /// <param name="converter"></param>
        public ControlReference(Type entityType, string propertyName, string control, IPropertiesInjector propertiesInjector, IValueConverter converter)
        {
            EntityType = entityType;
            PropertyName = propertyName;
            Control = control;
            IsSpecific = true;
            PropertiesInjector = propertiesInjector;
            Converter = converter;
        }

        public Type EntityType { get; set; }
        public string PropertyName { get; set; }
        public Type PropertyType { get; set; }
        public string Control { get; set; }
        public bool IsSpecific { get; set; }
        public bool IsRelationship { get; set; }
        public RelationshipMultiplicity RelationshipMultiplicity { get; set; }
        public IPropertiesInjector PropertiesInjector { get; set; }
        public IValueConverter Converter { get; set; }
    }
}
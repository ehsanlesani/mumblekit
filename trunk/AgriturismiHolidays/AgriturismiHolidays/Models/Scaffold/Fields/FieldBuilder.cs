using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Metadata.Edm;
using System.Reflection;
using Mumble.Web.StarterKit.Models.Scaffold.Exceptions;
using System.Web.Mvc;
using Mumble.Web.StarterKit.Models.Scaffold.Fields.Config;
using Mumble.Web.StarterKit.Models.Scaffold.Converters;

namespace Mumble.Web.StarterKit.Models.Scaffold.Fields
{
    /// <summary>
    /// Represents a control builder for Scaffolded entities' properties 
    /// </summary>
    public class FieldBuilder
    {
        #region Memory and constructor

        private ControlsMap _controlsMap;
        private string _controlsLibraryPath;

        public FieldBuilder()
        {
            _controlsMap = ControlsMap.CreateDefault();
            _controlsLibraryPath = "~/Views/Scaffold/Controls/";
        }

        #endregion

        #region Singleton

        private static FieldBuilder _instance = null;

        public static FieldBuilder Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new FieldBuilder();

                return _instance;
            }
        }

        #endregion

        #region Public methods

        /// <summary>
        /// Initialize a new instance of standard FieldControl
        /// </summary>
        /// <param name="entityType"></param>
        /// <param name="propertyName"></param>
        /// <returns></returns>
        public FieldControl CreateStandard(Type entityType, string propertyName)
        {
            ControlReference controlReference = FindStandardReference(entityType, propertyName);

            if (controlReference != null)
            {
                FieldControl controlInstance = LoadControl(controlReference.Control);
                if (controlInstance != null)
                {
                    controlInstance.Reference = controlReference;
                    return controlInstance;
                }
            }

            throw new ControlNotFoundException(entityType, propertyName);
        }

        /// <summary>
        /// Get standard control reference
        /// </summary>
        /// <param name="entityType"></param>
        /// <param name="propertyName"></param>
        /// <returns></returns>
        public ControlReference FindStandardReference(Type entityType, string propertyName)
        {
            ControlReference controlReference = SearchInSpecifics(entityType, propertyName);

            if (controlReference == null)
            {
                Type propertyType = GetPropertyType(entityType, propertyName);

                controlReference = (from cr in _controlsMap
                                    where cr.IsRelationship == false
                                    && cr.IsSpecific == false
                                    && (cr.PropertyType == propertyType || propertyType.IsSubclassOf(cr.PropertyType) || propertyType.GetInterfaces().Contains(cr.PropertyType))
                                    select cr).FirstOrDefault();
            }

            return controlReference;
        }

        /// <summary>
        /// Initialize a new instance of relationed FieldControl
        /// </summary>
        /// <param name="entityType"></param>
        /// <param name="propertyName"></param>
        /// <param name="relationshipMultiplicity"></param>
        /// <returns></returns>
        public FieldControl CreateRelationed(Type entityType, string propertyName, RelationshipMultiplicity relationshipMultiplicity)
        {
            ControlReference controlReference = FindRelationedReference(entityType, propertyName, relationshipMultiplicity);

            if (controlReference != null)
            {
                FieldControl controlInstance = LoadControl(controlReference.Control);
                if (controlInstance != null)
                {
                    controlInstance.Reference = controlReference;
                    return controlInstance;
                }
            }

            throw new ControlNotFoundException(entityType, propertyName);
        }

        /// <summary>
        /// Get relationed control reference
        /// </summary>
        /// <param name="entityType"></param>
        /// <param name="propertyName"></param>
        /// <param name="relationshipMultiplicity"></param>
        /// <returns></returns>
        public ControlReference FindRelationedReference(Type entityType, string propertyName, RelationshipMultiplicity relationshipMultiplicity)
        {
            ControlReference controlReference = SearchInSpecifics(entityType, propertyName);

            if (controlReference == null)
            {
                Type propertyType = GetPropertyType(entityType, propertyName);

                controlReference = (from cr in _controlsMap
                                     where cr.IsRelationship == true
                                     && cr.IsSpecific == false
                                     && cr.RelationshipMultiplicity == relationshipMultiplicity
                                     && (cr.PropertyType == propertyType || propertyType.IsSubclassOf(cr.PropertyType) || propertyType.GetInterfaces().Contains(cr.PropertyType))
                                     select cr).FirstOrDefault();
                
            }

            return controlReference;
        }

        /// <summary>
        /// Set control reference in map for the speficied property standard type
        /// </summary>
        /// <param name="propertyType"></param>
        /// <param name="control"></param>
        /// <param name="propertiesInjector">null for default injector</param>
        /// <param name="converter">null for default converter</param>
        public void SetControl(Type propertyType, string control, IPropertiesInjector propertiesInjector, IValueConverter converter)
        {
            ControlReference controlReference = (from cr in _controlsMap
                                                 where cr.PropertyType == propertyType
                                                 && cr.IsSpecific == false
                                                 && cr.IsRelationship == false
                                                 select cr).FirstOrDefault();

            if (controlReference == null)
            {
                _controlsMap.Insert(0, new ControlReference(propertyType, control, propertiesInjector, converter));
            }
            else
            {
                controlReference.Control = control;
                controlReference.PropertiesInjector = propertiesInjector;
                controlReference.Converter = converter;
            }
        }

        /// <summary>
        /// Set control reference in map for the speficied property relationed type
        /// </summary>
        /// <param name="propertyType"></param>
        /// <param name="relationshipMultiplicity"></param>
        /// <param name="control"></param>
        /// <param name="propertiesInjector">null for default injector</param>
        /// <param name="converter">null for default converter</param>
        public void SetControl(Type propertyType, RelationshipMultiplicity relationshipMultiplicity, string control, IPropertiesInjector propertiesInjector, IValueConverter converter)
        {
            ControlReference controlReference = (from cr in _controlsMap
                                                 where cr.PropertyType == propertyType
                                                 && cr.IsSpecific == false
                                                 && cr.IsRelationship == true
                                                 && cr.RelationshipMultiplicity == relationshipMultiplicity
                                                 select cr).FirstOrDefault();

            if (controlReference == null)
            {
                _controlsMap.Insert(0, new ControlReference(propertyType, relationshipMultiplicity, control, propertiesInjector, converter));
            }
            else
            {
                controlReference.Control = control;
                controlReference.PropertiesInjector = propertiesInjector;
                controlReference.Converter = converter;
            }
        }

        /// <summary>
        /// Set control reference in map for a specific property of a specific entity
        /// </summary>
        /// <param name="entityType"></param>
        /// <param name="propertyName"></param>
        /// <param name="controlType"></param>
        /// <param name="propertiesInjector">null for default injector</param>
        /// <param name="converter">null for default converter</param>
        public void SetControl(Type entityType, string propertyName, string control, IPropertiesInjector propertiesInjector, IValueConverter converter)
        {
            ControlReference controlReference = (from cr in _controlsMap
                                                 where cr.IsSpecific == true
                                                 && cr.EntityType == entityType
                                                 && cr.PropertyName == propertyName
                                                 select cr).FirstOrDefault();
            if (controlReference == null)
            {
                _controlsMap.Insert(0, new ControlReference(entityType, propertyName, control, propertiesInjector, converter));
            }
            else
            {
                controlReference.Control = control;
                controlReference.PropertiesInjector = propertiesInjector;
                controlReference.Converter = converter;
            }
        }

        /// <summary>
        /// Create a common resource
        /// </summary>
        /// <param name="resource">Resource to load</param>
        /// <param name="action"></param>
        /// <returns></returns>
        public FieldControl CreateCommon(CommonResource resource, ScaffoldAction action)
        {
            string resourcePath = String.Format("Commons/{0}{1}.ascx", resource.ToString(), action.ToString());
            FieldControl controlInstance = LoadControl(resourcePath);
            if (controlInstance != null)
                return controlInstance;

            throw new ResourceNotFoundException(resourcePath);            
        }

        #endregion

        #region Private methods

        private Type GetPropertyType(Type entityType, string propertyName)
        {
            PropertyInfo property = entityType.GetProperty(propertyName);
            if (property == null)
            {
                throw new PropertyNotFoundException(entityType, propertyName);
            }

            return property.PropertyType;
        }

        private ControlReference SearchInSpecifics(Type entityType, string propertyName)
        {
            var controlReference = (from cr in _controlsMap
                           where cr.IsSpecific == true
                           && (cr.EntityType == entityType || entityType.IsSubclassOf(cr.EntityType) || entityType.GetInterfaces().Contains(cr.EntityType))
                           && cr.PropertyName == propertyName
                           select cr).FirstOrDefault();

            return controlReference;
        }

        private FieldControl LoadControl(string control)
        {
            return new ViewUserControl().LoadControl(String.Format("{0}{1}", _controlsLibraryPath, control)) as FieldControl;
        }

        #endregion
    }
}
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Mumble.Web.StarterKit.Models.Scaffold.Metadata;
using Mumble.Web.StarterKit.Models.Scaffold.Fields.Config;
using Mumble.Web.StarterKit.Models.Scaffold.Mvc;

namespace Mumble.Web.StarterKit.Models.Scaffold.Fields
{
    /// <summary>
    /// Represent the base class for all Scaffolded properties controls
    /// </summary>
    public class FieldControl : ViewUserControl
    {
        private Dictionary<string, object> _properties = new Dictionary<string,object>();
        private Dictionary<string, Type> _requiredProperties = new Dictionary<string, Type>();

        public FieldMetadata FieldMetadata { get; set; }
        public RelationshipMetadata RelationshipMetadata { get; set; }
        public ControlReference Reference { get; set; }
        public virtual string Value { get; set; }

        /// <summary>
        /// Add additional properties
        /// </summary>
        /// <param name="key"></param>
        /// <param name="value"></param>
        public void AddProperty(string key, object value)
        {
            _properties.Add(key, value);
        }

        /// <summary>
        /// Get additional property value
        /// </summary>
        /// <typeparam name="T"></typeparam>
        /// <param name="key"></param>
        /// <returns></returns>
        public T GetProperty<T>(string key)
        {
            if (_properties.ContainsKey(key)) return (T)_properties[key];
            else return default(T);
        }

        /// <summary>
        /// Add a required for rendering property
        /// </summary>
        /// <param name="key"></param>
        /// <param name="type"></param>
        public void AddRequiredProperty(string key, Type type)
        {
            _requiredProperties.Add(key, type);
        }

        protected override void OnPreRender(EventArgs e)
        {
            CheckProperties();
            base.OnPreRender(e);
        }

        /// <summary>
        /// Check if all required properties are setted
        /// </summary>
        protected virtual void CheckProperties()
        {
            foreach (KeyValuePair<string, Type> required in _requiredProperties)
            {
                if (_properties.ContainsKey(required.Key))
                {
                    Type valueType = _properties[required.Key].GetType();
                    if(!valueType.Equals(required.Value))
                        throw new InvalidOperationException(String.Format("{0} is not {1} but is {2}", required.Key, required.Value.FullName, valueType.FullName));
                }
                else
                {
                    throw new InvalidOperationException(String.Format("{0} property not found", required.Key));
                }            
            }
        }
    }
}
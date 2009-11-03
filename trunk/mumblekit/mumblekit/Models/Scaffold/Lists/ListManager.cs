using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Reflection;

namespace Mumble.Web.StarterKit.Models.Scaffold.Lists
{
    /// <summary>
    /// Represent manager for lists
    /// </summary>
    public class ListManager
    {
        #region Singleton

        private ListManager() { }

        private static ListManager _instance;

        public static ListManager Instance
        {
            get
            {
                if (_instance == null)
                    _instance = new ListManager();

                return _instance;
            }
        }

        #endregion

        private Dictionary<Type, ListConfiguration> _configurations = new Dictionary<Type, ListConfiguration>();

        /// <summary>
        /// Get list configuration for specified type if exists, otherwise return a new standard configuration based on all properties of entity
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        public ListConfiguration GetConfiguration(Type type)
        {
            ListConfiguration config = null;

            if(_configurations.ContainsKey(type))
            {
                config = _configurations[type];
            }
            else
            {
                config = CreateStandardConfig(type);
                //add for caching
                RegisterConfiguration(type, config);
            }

            return config;
        }

        /// <summary>
        /// Register a new list configuration for specified type or update an existing one
        /// </summary>
        /// <param name="type"></param>
        /// <param name="configuration"></param>
        public void RegisterConfiguration(Type type, ListConfiguration configuration)
        {
            if (_configurations.ContainsKey(type))
            {
                _configurations[type] = configuration;
            }
            else
            {
                _configurations.Add(type, configuration);
            }
        }

        /// <summary>
        /// Create standard configuration for specified type
        /// </summary>
        /// <param name="type"></param>
        /// <returns></returns>
        private ListConfiguration CreateStandardConfig(Type type)
        {
            PropertyInfo[] properties = type.GetProperties();
            ListConfiguration config = new ListConfiguration();
            foreach (var property in properties)
            {
                config.AddColumn(property.Name, property.Name);
            }

            return config;
        }
    }
}
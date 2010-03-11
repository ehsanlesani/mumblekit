﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Reflection;
using Mumble.Timerou.Models.Exceptions;
using System.Linq.Expressions;

namespace Mumble.Timerou.Models.ViewData
{
    /// <summary>
    /// Represents the base model class and provide functions to get safe values from value object
    /// </summary>
    public abstract class BaseModel<T>
    {
        private Dictionary<Type, object> _extraValueObjects = new Dictionary<Type, object>();

        /// <summary>
        /// Add an extra value object for usage with Val of other types
        /// </summary>
        protected virtual void AddExtraValueObject(Type type, object entity)
        {
            _extraValueObjects.Add(type, entity);
        }

        /// <summary>
        /// Gets value object to use in html pages
        /// </summary>
        /// <returns></returns>
        protected abstract T GetValueObject();

        /// <summary>
        /// Gets null reference save value from value object using expression (for refactoring and code assist). Default is used if function result is null;
        /// </summary>
        /// <param name="expression"></param>
        /// <returns></returns>
        public string Val(Func<T, object> fn, string defaultValue)
        {
            T valueObject = GetValueObject();
            if (valueObject != null)
            {
                object value = fn(valueObject);
                if (value != null)
                {
                    return value.ToString();
                }
            }

            return defaultValue;
        }

        /// <summary>
        /// Gets null reference save value from value object using expression (for refactoring and code assist)
        /// </summary>
        /// <param name="expression"></param>
        /// <returns></returns>
        public string Val(Func<T, object> fn)
        {
            T valueObject = GetValueObject();
            if(valueObject!=null) {
                object value = fn(valueObject);
                if (value != null)
                {
                    return value.ToString();
                }
            }

            return string.Empty;
        }

        /// <summary>
        /// Gets null reference save value from value object
        /// </summary>
        /// <param name="property"></param>
        /// <returns></returns>
        public string Val(string property)
        {
            object valueObject = GetValueObject();
            if (valueObject != null)
            {
                PropertyInfo propertyInfo = valueObject.GetType().GetProperty(property);
                if (propertyInfo == null)
                {
                    throw new PropertyNotFoundException(property);
                }

                object value = propertyInfo.GetValue(valueObject, null);
                if (value != null)
                {
                    return value.ToString();
                }
            }

            return String.Empty;
        }

        /// <summary>
        /// Gets null reference save value from an extra value object using expression (for refactoring and code assist)
        /// </summary>
        /// <param name="expression"></param>
        /// <returns></returns>
        public string Val<C>(Func<C, object> fn)
        {
            C valueObject = (C)_extraValueObjects[typeof(C)];
            if (valueObject != null)
            {
                object value = fn(valueObject);
                if (value != null)
                {
                    return value.ToString();
                }
            }

            return string.Empty;
        }
    }
}

using System;
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
    public class BaseModel
    {
        private T GetValueObject<T>()
        {
            foreach (var property in GetType().GetProperties())
            {
                ModelValueAttribute attr = property.GetCustomAttributes(typeof(ModelValueAttribute), false).FirstOrDefault() as ModelValueAttribute;
                if (attr != null)
                {
                    if (property.PropertyType.Equals(typeof(T)))
                    {
                        return (T)property.GetValue(this, null);
                    }
                }
            }

            throw new ValueObjectNotFoundException(typeof(T));
        }

        /// <summary>
        /// Gets null reference save value from value object using expression (for refactoring and code assist). Default is used if function result is null;
        /// </summary>
        /// <param name="expression"></param>
        /// <returns></returns>
        public string Val<T>(Func<T, object> fn, string defaultValue)
        {
            T valueObject = GetValueObject<T>();
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
        public string Val<T>(Func<T, object> fn)
        {
            return Val<T>(fn, String.Empty);
        }
    }
}

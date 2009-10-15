using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Reflection;
using Mumble.Web.StarterKit.Models.Scaffold.Exceptions;

namespace Mumble.Web.StarterKit.Models.Scaffold.Converters
{
    public class OneRelationshipConverter : IValueConverter
    {
        public object Convert(string value)
        {
            return new GuidConverter().Convert(value);
        }

        public string Convert(object value)
        {
            if (value != null)
            {
                Type type = value.GetType();
                PropertyInfo propertyInfo = type.GetProperty("Id");

                if (propertyInfo == null)
                    throw new MalformedEntityException(String.Format("Id property of {0} not found", type.FullName));

                object id = propertyInfo.GetValue(value, null);
                if (id != null)
                    return id.ToString();
            }

            return null;
        }
    }
}
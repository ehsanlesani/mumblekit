using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Reflection;
using Mumble.Web.StarterKit.Models.Scaffold.Exceptions;
using System.Collections;
using System.Text;
using System.Data.Objects.DataClasses;

namespace Mumble.Web.StarterKit.Models.Scaffold.Converters
{
    public class ManyRelationshipConverter : IValueConverter
    {
        public object Convert(string value)
        {
            if (value == null)
                return new Guid[0];
            
            string[] sids = value.Split(',');
            Guid[] ids = new Guid[sids.Length];
            GuidConverter guidConverter = new GuidConverter();
            for (int i = 0; i < sids.Length; i++)
            {
                var sid = sids[i];
                ids[i] = (Guid)guidConverter.Convert(sid);
            }

            return ids;
        }

        public string Convert(object value)
        {
            if (value != null)
            {
                StringBuilder ids = new StringBuilder();
                IRelatedEnd collection = (IRelatedEnd)value;
                if (!collection.IsLoaded)
                    collection.Load();

                foreach (object item in collection)
                {
                    Type type = item.GetType();
                    PropertyInfo propertyInfo = type.GetProperty("Id");

                    if (propertyInfo == null)
                        throw new MalformedEntityException(String.Format("Id property of {0} not found", type.FullName));

                    object id = propertyInfo.GetValue(item, null);
                    if (id != null)
                        ids.AppendFormat("{0},", id);
                }

                //remove last comma
                if (ids.Length > 1)
                {
                    ids.Remove(ids.Length - 1, 1);
                }
                return ids.ToString();
            }

            return null;
        }
    }
}
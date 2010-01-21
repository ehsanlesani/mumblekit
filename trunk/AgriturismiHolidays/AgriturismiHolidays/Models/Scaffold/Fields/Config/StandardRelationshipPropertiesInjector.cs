using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Mumble.Web.StarterKit.Models.Scaffold.Exceptions;
using System.Reflection;

namespace Mumble.Web.StarterKit.Models.Scaffold.Fields.Config
{
    /// <summary>
    /// Represent properties injector for field when no one is specified
    /// </summary>
    public class StandardRelationshipPropertiesInjector : IPropertiesInjector
    {
        public void Inject(FieldControl fieldControl, Scaffolder Scaffolder)
        {
            var items = Scaffolder.ObjectContext.CreateQuery<object>(fieldControl.RelationshipMetadata.To.EntitySet).ToList();

            List<SelectListItem> selectItems = new List<SelectListItem>();
            //selectItems.Add(new SelectListItem() { Text = "(Seleziona)", Value = null, Selected = true });

            foreach (var item in items)
            {
                Type type = item.GetType();

                object value = null;
                string label = item.ToString();

                PropertyInfo idProperty = type.GetProperty("Id");
                if (idProperty != null) { value = idProperty.GetValue(item, null); }
                else { throw new MalformedEntityException(String.Format("Id property of {0} not found", type.FullName)); }

                selectItems.Add(new SelectListItem() { Text = label, Value = value.ToString() });
            }

            fieldControl.AddProperty("Items", new SelectList(selectItems, "Value", "Text"));
        }
    }
}
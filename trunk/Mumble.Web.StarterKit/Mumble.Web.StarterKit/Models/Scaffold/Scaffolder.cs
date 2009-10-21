using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Objects;
using System.Data.Metadata.Edm;
using System.Web.UI;
using System.IO;
using Mumble.Web.StarterKit.Models.Scaffold.Fields;
using System.Web.Mvc;
using System.Data.Objects.DataClasses;
using Mumble.Web.StarterKit.Models.Scaffold.Metadata;
using Mumble.Web.StarterKit.Models.Scaffold.Events;
using Mumble.Web.StarterKit.Models.Scaffold.Fields.Config;
using Mumble.Web.StarterKit.Models.Scaffold.Converters;
using System.Reflection;
using Mumble.Web.StarterKit.Models.Scaffold.Exceptions;
using System.Collections.Specialized;
using Mumble.Web.StarterKit.Models.Scaffold.Lists;
using Mumble.Web.StarterKit.Models.Scaffold.Mvc;

namespace Mumble.Web.StarterKit.Models.Scaffold
{
    /// <summary>
    /// Represents the Scaffolding manager. NB: All Scaffolded entities MUST have Id property as Guid.
    /// </summary>
    public class Scaffolder
    {
        #region Events

        /// <summary>
        /// Occurs when a new control is created but not rendered. Render is cancelable
        /// </summary>
        public event EventHandler<ControlCreatedEventArgs> ControlCreated;

        /// <summary>
        /// Occurs before existing entity save
        /// </summary>
        public event EventHandler<BeforeUpdateEventArgs> BeforeUpdate;

        /// <summary>
        /// Occurs before new entity save
        /// </summary>
        public event EventHandler<BeforeInsertEventArgs> BeforeInsert;

        /// <summary>
        /// Occurs before editing entities
        /// </summary>
        public event EventHandler<BeforeEditEventArgs> BeforeEdit;

        #endregion

        /// <summary>
        /// Contains the current instance of Scaffolder
        /// </summary>
        public static Scaffolder Current { get; private set; }

        public Scaffolder(ObjectContext objectContext)
        {
            ObjectContext = objectContext;

            Current = this;
        }

        public ObjectContext ObjectContext { get; set; }
        public object CurrentEntity { get; private set; }

        /// <summary>
        /// Create controls for editing
        /// </summary>
        /// <param name="viewContext">The ViewContext to render into</param>
        /// <param name="entity">The entity to edit</param>
        /// <param name="id">Entity to edit identifier. Null for new Entities)</param>
        public void Edit(ViewContext viewContext, Type entityType, Guid? id)
        {
            //set current entity id
            //CurrentEntityId = id;
            
            //load metadata
            MetadataBuilder metadataBuilder = new MetadataBuilder(ObjectContext, entityType);
            MetadataDescriptor entityMetadata = metadataBuilder.Build();

            //get valued entity instance
            object entityInstance = null;
            if(id.HasValue)
                entityInstance = ObjectContext.GetObjectByKey(new System.Data.EntityKey(String.Format("{0}.{1}", ObjectContext.DefaultContainerName, entityMetadata.EntitySet), "Id", id));

            CurrentEntity = entityInstance;
            
            if (BeforeEdit != null)
                BeforeEdit.Invoke(this, new BeforeEditEventArgs(entityInstance));

            //render "edit" header
            FieldControl headerControl = FieldBuilder.Instance.CreateCommon(CommonResource.Header, ScaffoldAction.Edit);
            headerControl.RenderView(viewContext);

            foreach (var field in entityMetadata.Fields)
            {
                FieldControl control = FieldBuilder.Instance.CreateStandard(entityType, field.Name);
                control.FieldMetadata = field;
                //inject properties to control
                IPropertiesInjector propertiesInjector = control.Reference.PropertiesInjector ?? new StandardFieldPropertiesInjector();
                propertiesInjector.Inject(control, this);

                //set value to control
                if (entityInstance != null)
                {
                    IValueConverter converter = control.Reference.Converter ?? new StringConverter();
                    object entityValue = GetValue(entityInstance, entityType, field.Name);
                    string htmlValue = converter.Convert(entityValue);
                    control.Value = htmlValue;
                }

                if (ControlCreated != null)
                {
                    ControlCreatedEventArgs eventArgs = new ControlCreatedEventArgs(entityType, field.Name, control);
                    ControlCreated.Invoke(this, eventArgs);
                    if (eventArgs.Cancel)
                        continue;
                }

                control.RenderView(viewContext);
            }

            foreach (var relationship in entityMetadata.Relationships)
            {
                FieldControl control = FieldBuilder.Instance.CreateRelationed(entityType, relationship.Name, relationship.To.RelationshipMultiplicity);
                control.RelationshipMetadata = relationship;
                //inject properties to control
                IPropertiesInjector propertiesInjector = control.Reference.PropertiesInjector ?? new StandardRelationshipPropertiesInjector();
                propertiesInjector.Inject(control, this);

                //set value to control
                if (entityInstance != null)
                {
                    IValueConverter converter = null;
                    if (relationship.To.RelationshipMultiplicity == RelationshipMultiplicity.One || relationship.To.RelationshipMultiplicity == RelationshipMultiplicity.ZeroOrOne)
                    {
                        converter = control.Reference.Converter ?? new OneRelationshipConverter();
                    }
                    else if (relationship.To.RelationshipMultiplicity == RelationshipMultiplicity.Many)
                    {
                        converter = control.Reference.Converter ?? new ManyRelationshipConverter();
                    }

                    object entityValue = GetValue(entityInstance, entityType, relationship.Name);
                    string htmlValue = converter.Convert(entityValue);
                    control.Value = htmlValue;
                }

                if (ControlCreated != null)
                {
                    ControlCreatedEventArgs eventArgs = new ControlCreatedEventArgs(entityType, relationship.Name, control);
                    ControlCreated.Invoke(this, eventArgs);
                    if (eventArgs.Cancel)
                        continue;
                }

                control.RenderView(viewContext);
            }

            //render "edit" footer
            FieldControl footerControl = FieldBuilder.Instance.CreateCommon(CommonResource.Footer, ScaffoldAction.Edit);
            footerControl.RenderView(viewContext);

        }

        /// <summary>
        /// Save an entity using values posted in a form
        /// </summary>
        /// <param name="entityType"></param>
        /// <param name="values"></param>
        public void Save(Type entityType, NameValueCollection values)
        {
            //load metadata
            MetadataBuilder metadataBuilder = new MetadataBuilder(ObjectContext, entityType);
            MetadataDescriptor entityMetadata = metadataBuilder.Build();

            //try to get id from
            IValueConverter guidConverter = new GuidConverter();
            Guid? id = guidConverter.Convert(values.Get("Id")) as Guid?;
            if (!id.HasValue)
            {
                id = Guid.NewGuid();
            }

            //get valued entity instance if exists or create a new one
            object entityInstance = null;
            if (!ObjectContext.TryGetObjectByKey(new System.Data.EntityKey(String.Format("{0}.{1}", ObjectContext.DefaultContainerName, entityMetadata.EntitySet), "Id", id), out entityInstance))
            {
                entityInstance = Activator.CreateInstance(entityType);
                ObjectContext.AddObject(entityMetadata.EntitySet, entityInstance);
                SetValue(entityInstance, entityType, "Id", id);

                CurrentEntity = entityInstance;
                
                //raise before insert event
                if (BeforeInsert != null)
                    BeforeInsert.Invoke(this, new BeforeInsertEventArgs(entityInstance));
            }
            else
            {
                CurrentEntity = entityInstance;

                //raise before update event
                if (BeforeUpdate != null)
                    BeforeUpdate.Invoke(this, new BeforeUpdateEventArgs(entityInstance));
            }

            //values standard field
            foreach (var field in entityMetadata.Fields)
            {
                if (field.Name.Equals("Id"))
                    continue;
                
                //instanziate control reference to get converter
                ControlReference controlReference = FieldBuilder.Instance.FindStandardReference(entityType, field.Name);
                IValueConverter converter = controlReference.Converter ?? new StringConverter();
                string htmlValue = values.Get(field.Name);
                object entityValue = converter.Convert(htmlValue);
                SetValue(entityInstance, entityType, field.Name, entityValue);
            }

            //values relationed field
            foreach (var relationship in entityMetadata.Relationships)
            {
                //instanziate control reference to get converter
                if (relationship.To.RelationshipMultiplicity == RelationshipMultiplicity.One || relationship.To.RelationshipMultiplicity == RelationshipMultiplicity.ZeroOrOne)
                {
                    ControlReference controlReference = FieldBuilder.Instance.FindRelationedReference(entityType, relationship.Name, relationship.To.RelationshipMultiplicity);
                    IValueConverter converter = controlReference.Converter ?? new GuidConverter();
                    string htmlValue = values.Get(relationship.Name);
                    Guid? relatedEntityID = (Guid?)converter.Convert(htmlValue);
                    object relatedEntity = null;
                    if (relatedEntityID.HasValue)
                    {
                        ObjectContext.TryGetObjectByKey(new System.Data.EntityKey(String.Format("{0}.{1}", ObjectContext.DefaultContainerName, relationship.EntitySet), "Id", relatedEntityID), out relatedEntity);
                    }
                    SetValue(entityInstance, entityType, relationship.Name, relatedEntity);
                }
                else if (relationship.To.RelationshipMultiplicity == RelationshipMultiplicity.Many)
                {
                    //call just converter. relations are managed by childs. TO COMPLETE
                    ControlReference controlReference = FieldBuilder.Instance.FindRelationedReference(entityType, relationship.Name, relationship.To.RelationshipMultiplicity);
                    IValueConverter converter = controlReference.Converter ?? new ManyRelationshipConverter();
                    string htmlValue = values.Get(relationship.Name);
                    object controlValue = converter.Convert(htmlValue);
                    
                    //for standard usage the controlValue must be a a Guid[] thah contains list of entities relationed to current entity. Return null in a custom converter to skip this passage
                    if (controlValue != null)
                    {
                        Guid[] relatedIds = (Guid[])controlValue;
                        
                        //get collection
                        IRelatedEnd collection = (IRelatedEnd)GetValue(entityInstance, entityType, relationship.Name);
                        List<IEntityWithRelationships> removeList = new List<IEntityWithRelationships>();

                        if (!collection.IsLoaded)
                            collection.Load();

                        //remove existing relations
                        foreach (var toRemove in collection)
                        {
                            removeList.Add((IEntityWithRelationships)toRemove);
                        }

                        foreach (var toRemove in removeList)
                        {
                            collection.Remove(toRemove);
                        }

                        //get all related entities by id
                        foreach (Guid relatedEntityId in relatedIds)
                        {
                            object relatedEntity = null;
                            if (ObjectContext.TryGetObjectByKey(new System.Data.EntityKey(String.Format("{0}.{1}", ObjectContext.DefaultContainerName, relationship.EntitySet), "Id", relatedEntityId), out relatedEntity))
                            {
                                collection.Add((IEntityWithRelationships)relatedEntity);
                            }
                        }
                    }
                }
            }

            ObjectContext.SaveChanges();
        }

        /// <summary>
        /// Delete an entity from datacontext
        /// </summary>
        /// <param name="entityType"></param>
        /// <param name="id"></param>
        public void Delete(Type entityType, Guid id)
        {
            //load metadata
            MetadataBuilder metadataBuilder = new MetadataBuilder(ObjectContext, entityType);
            MetadataDescriptor entityMetadata = metadataBuilder.Build();

            //get and delete entity if exists 
            object entityInstance = null;
            if (ObjectContext.TryGetObjectByKey(new System.Data.EntityKey(String.Format("{0}.{1}", ObjectContext.DefaultContainerName, entityMetadata.EntitySet), "Id", id), out entityInstance))
            {
                ObjectContext.DeleteObject(entityInstance);
                ObjectContext.SaveChanges();
            }
        }

        /// <summary>
        /// Create a list of entities
        /// </summary>
        /// <param name="viewContext"></param>
        /// <param name="entityType"></param>
        /// <param name="configuration"></param>
        public void List(ViewContext viewContext, Type entityType)
        {
            //load metadata
            MetadataBuilder metadataBuilder = new MetadataBuilder(ObjectContext, entityType);
            MetadataDescriptor entityMetadata = metadataBuilder.Build();

            //get list configuration
            ListConfiguration configuration = ListManager.Instance.GetConfiguration(entityType);

            //load all entities from db
            var entities = ObjectContext.CreateQuery<object>(entityMetadata.EntitySet);

            List<Row> data = new List<Row>();
            foreach (var entity in entities)
            {
                Row row = new Row();
                Guid id = (Guid)GetValue(entity, entityType, "Id");
                row.Id = id;
                object[] values = new object[configuration.Columns.Count];
                int index = 0;
                foreach (ColumnConfiguration column in configuration.Columns)
                {
                    object value = GetValue(entity, entityType, column.Name);
                    string formattedValue = column.Formatter.Invoke(value);
                    values[index] = formattedValue;
                    index++;
                }
                row.Values = values;
                data.Add(row);
            }

            //instanziate list control
            ListControl listControl = (ListControl)new ViewUserControl().LoadControl("~/Views/Scaffold/Controls/Lists/List.ascx");
            listControl.Data = data;
            listControl.ViewData = viewContext.ViewData;
            listControl.Configuration = configuration;
            listControl.RenderView(viewContext);
        }

        private object GetValue(object instance, Type entityType, string fieldName)
        {
            PropertyInfo property = entityType.GetProperty(fieldName);
            if (property == null)
                throw new PropertyNotFoundException(entityType, fieldName);

            return property.GetValue(instance, null);
        }

        private void SetValue(object instance, Type entityType, string fieldName, object value)
        {
            PropertyInfo property = entityType.GetProperty(fieldName);
            if (property == null)
                throw new PropertyNotFoundException(entityType, fieldName);

            property.SetValue(instance, value, null);
        }
    }

}
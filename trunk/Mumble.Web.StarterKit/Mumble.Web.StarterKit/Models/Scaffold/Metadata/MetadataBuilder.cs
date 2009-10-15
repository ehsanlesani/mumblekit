using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Objects;
using System.Data.Metadata.Edm;
using Mumble.Web.StarterKit.Models.Scaffold.Exceptions;

namespace Mumble.Web.StarterKit.Models.Scaffold.Metadata
{
    /// <summary>
    /// Represents the metadatabuilder for entity
    /// </summary>
    public class MetadataBuilder
    {
        public ObjectContext _objectContext;
        public Type _entityType;

        public MetadataBuilder(ObjectContext objectContext, Type entityType)
        {
            _objectContext = objectContext;
            _entityType = entityType;
        }

        public MetadataDescriptor Build()
        {
            MetadataDescriptor metadata = (from meta in _objectContext.MetadataWorkspace.GetItems(DataSpace.CSpace)
                                           where meta.BuiltInTypeKind == BuiltInTypeKind.EntityType
                                           let m = (meta as EntityType)
                                           where m.Name == _entityType.Name
                                           select new MetadataDescriptor()
                                           {
                                               Fields = from p in m.Properties
                                                        select new FieldMetadata
                                                        {
                                                            Name = p.Name,
                                                            Type = p.TypeUsage.EdmType.Name,
                                                            Nullable = p.Nullable
                                                        },
                                               Relationships = from p in m.NavigationProperties
                                                               select new RelationshipMetadata
                                                               {
                                                                   From = new RelationInfo() { MemberName = p.FromEndMember.Name, RelationshipMultiplicity = p.FromEndMember.RelationshipMultiplicity },
                                                                   To = new RelationInfo() { MemberName = p.ToEndMember.Name, RelationshipMultiplicity = p.ToEndMember.RelationshipMultiplicity },
                                                                   EntitySet = (from es in _objectContext.MetadataWorkspace.GetEntityContainer(_objectContext.DefaultContainerName, DataSpace.CSpace).BaseEntitySets
                                                                                where es.ElementType.Name.Equals(((RefType)p.ToEndMember.TypeUsage.EdmType).ElementType.Name)
                                                                                select es.Name).FirstOrDefault(),
                                                                   Name = p.Name

                                                               },
                                               EntitySet = (from es in _objectContext.MetadataWorkspace.GetEntityContainer(_objectContext.DefaultContainerName, DataSpace.CSpace).BaseEntitySets
                                                            where es.ElementType.Name.Equals(_entityType.Name)
                                                            select es.Name).FirstOrDefault()
                                           }).FirstOrDefault();

            if (metadata == null)
            {
                throw new MetadataNotFoundException(_entityType);
            }

            return metadata;
        }

    }
}
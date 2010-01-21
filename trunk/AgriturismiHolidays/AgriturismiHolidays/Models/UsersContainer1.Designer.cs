﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:2.0.50727.4927
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

[assembly: global::System.Data.Objects.DataClasses.EdmSchemaAttribute()]
[assembly: global::System.Data.Objects.DataClasses.EdmRelationshipAttribute("Users", "GroupUser", "Group", global::System.Data.Metadata.Edm.RelationshipMultiplicity.Many, typeof(Mumble.Web.StarterKit.Models.Group), "User", global::System.Data.Metadata.Edm.RelationshipMultiplicity.Many, typeof(Mumble.Web.StarterKit.Models.User))]

// Original file name:
// Generation date: 21/01/2010 18:03:14
namespace Mumble.Web.StarterKit.Models
{
    
    /// <summary>
    /// There are no comments for UsersContainer in the schema.
    /// </summary>
    public partial class UsersContainer : global::System.Data.Objects.ObjectContext
    {
        /// <summary>
        /// Initializes a new UsersContainer object using the connection string found in the 'UsersContainer' section of the application configuration file.
        /// </summary>
        public UsersContainer() : 
                base("name=UsersContainer", "UsersContainer")
        {
            this.OnContextCreated();
        }
        /// <summary>
        /// Initialize a new UsersContainer object.
        /// </summary>
        public UsersContainer(string connectionString) : 
                base(connectionString, "UsersContainer")
        {
            this.OnContextCreated();
        }
        /// <summary>
        /// Initialize a new UsersContainer object.
        /// </summary>
        public UsersContainer(global::System.Data.EntityClient.EntityConnection connection) : 
                base(connection, "UsersContainer")
        {
            this.OnContextCreated();
        }
        partial void OnContextCreated();
        /// <summary>
        /// There are no comments for Users in the schema.
        /// </summary>
        public global::System.Data.Objects.ObjectQuery<User> Users
        {
            get
            {
                if ((this._Users == null))
                {
                    this._Users = base.CreateQuery<User>("[Users]");
                }
                return this._Users;
            }
        }
        private global::System.Data.Objects.ObjectQuery<User> _Users;
        /// <summary>
        /// There are no comments for Groups in the schema.
        /// </summary>
        public global::System.Data.Objects.ObjectQuery<Group> Groups
        {
            get
            {
                if ((this._Groups == null))
                {
                    this._Groups = base.CreateQuery<Group>("[Groups]");
                }
                return this._Groups;
            }
        }
        private global::System.Data.Objects.ObjectQuery<Group> _Groups;
        /// <summary>
        /// There are no comments for Users in the schema.
        /// </summary>
        public void AddToUsers(User user)
        {
            base.AddObject("Users", user);
        }
        /// <summary>
        /// There are no comments for Groups in the schema.
        /// </summary>
        public void AddToGroups(Group group)
        {
            base.AddObject("Groups", group);
        }
    }
    /// <summary>
    /// There are no comments for Users.User in the schema.
    /// </summary>
    /// <KeyProperties>
    /// Id
    /// </KeyProperties>
    [global::System.Data.Objects.DataClasses.EdmEntityTypeAttribute(NamespaceName="Users", Name="User")]
    [global::System.Runtime.Serialization.DataContractAttribute(IsReference=true)]
    [global::System.Serializable()]
    public partial class User : global::System.Data.Objects.DataClasses.EntityObject
    {
        /// <summary>
        /// Create a new User object.
        /// </summary>
        /// <param name="id">Initial value of Id.</param>
        /// <param name="email">Initial value of Email.</param>
        /// <param name="password">Initial value of Password.</param>
        public static User CreateUser(global::System.Guid id, string email, string password)
        {
            User user = new User();
            user.Id = id;
            user.Email = email;
            user.Password = password;
            return user;
        }
        /// <summary>
        /// There are no comments for Property Id in the schema.
        /// </summary>
        [global::System.Data.Objects.DataClasses.EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [global::System.Runtime.Serialization.DataMemberAttribute()]
        public global::System.Guid Id
        {
            get
            {
                return this._Id;
            }
            set
            {
                this.OnIdChanging(value);
                this.ReportPropertyChanging("Id");
                this._Id = global::System.Data.Objects.DataClasses.StructuralObject.SetValidValue(value);
                this.ReportPropertyChanged("Id");
                this.OnIdChanged();
            }
        }
        private global::System.Guid _Id;
        partial void OnIdChanging(global::System.Guid value);
        partial void OnIdChanged();
        /// <summary>
        /// There are no comments for Property FirstName in the schema.
        /// </summary>
        [global::System.Data.Objects.DataClasses.EdmScalarPropertyAttribute()]
        [global::System.Runtime.Serialization.DataMemberAttribute()]
        public string FirstName
        {
            get
            {
                return this._FirstName;
            }
            set
            {
                this.OnFirstNameChanging(value);
                this.ReportPropertyChanging("FirstName");
                this._FirstName = global::System.Data.Objects.DataClasses.StructuralObject.SetValidValue(value, true);
                this.ReportPropertyChanged("FirstName");
                this.OnFirstNameChanged();
            }
        }
        private string _FirstName;
        partial void OnFirstNameChanging(string value);
        partial void OnFirstNameChanged();
        /// <summary>
        /// There are no comments for Property LastName in the schema.
        /// </summary>
        [global::System.Data.Objects.DataClasses.EdmScalarPropertyAttribute()]
        [global::System.Runtime.Serialization.DataMemberAttribute()]
        public string LastName
        {
            get
            {
                return this._LastName;
            }
            set
            {
                this.OnLastNameChanging(value);
                this.ReportPropertyChanging("LastName");
                this._LastName = global::System.Data.Objects.DataClasses.StructuralObject.SetValidValue(value, true);
                this.ReportPropertyChanged("LastName");
                this.OnLastNameChanged();
            }
        }
        private string _LastName;
        partial void OnLastNameChanging(string value);
        partial void OnLastNameChanged();
        /// <summary>
        /// There are no comments for Property Address in the schema.
        /// </summary>
        [global::System.Data.Objects.DataClasses.EdmScalarPropertyAttribute()]
        [global::System.Runtime.Serialization.DataMemberAttribute()]
        public string Address
        {
            get
            {
                return this._Address;
            }
            set
            {
                this.OnAddressChanging(value);
                this.ReportPropertyChanging("Address");
                this._Address = global::System.Data.Objects.DataClasses.StructuralObject.SetValidValue(value, true);
                this.ReportPropertyChanged("Address");
                this.OnAddressChanged();
            }
        }
        private string _Address;
        partial void OnAddressChanging(string value);
        partial void OnAddressChanged();
        /// <summary>
        /// There are no comments for Property City in the schema.
        /// </summary>
        [global::System.Data.Objects.DataClasses.EdmScalarPropertyAttribute()]
        [global::System.Runtime.Serialization.DataMemberAttribute()]
        public string City
        {
            get
            {
                return this._City;
            }
            set
            {
                this.OnCityChanging(value);
                this.ReportPropertyChanging("City");
                this._City = global::System.Data.Objects.DataClasses.StructuralObject.SetValidValue(value, true);
                this.ReportPropertyChanged("City");
                this.OnCityChanged();
            }
        }
        private string _City;
        partial void OnCityChanging(string value);
        partial void OnCityChanged();
        /// <summary>
        /// There are no comments for Property Email in the schema.
        /// </summary>
        [global::System.Data.Objects.DataClasses.EdmScalarPropertyAttribute(IsNullable=false)]
        [global::System.Runtime.Serialization.DataMemberAttribute()]
        public string Email
        {
            get
            {
                return this._Email;
            }
            set
            {
                this.OnEmailChanging(value);
                this.ReportPropertyChanging("Email");
                this._Email = global::System.Data.Objects.DataClasses.StructuralObject.SetValidValue(value, false);
                this.ReportPropertyChanged("Email");
                this.OnEmailChanged();
            }
        }
        private string _Email;
        partial void OnEmailChanging(string value);
        partial void OnEmailChanged();
        /// <summary>
        /// There are no comments for Property Password in the schema.
        /// </summary>
        [global::System.Data.Objects.DataClasses.EdmScalarPropertyAttribute(IsNullable=false)]
        [global::System.Runtime.Serialization.DataMemberAttribute()]
        public string Password
        {
            get
            {
                return this._Password;
            }
            set
            {
                this.OnPasswordChanging(value);
                this.ReportPropertyChanging("Password");
                this._Password = global::System.Data.Objects.DataClasses.StructuralObject.SetValidValue(value, false);
                this.ReportPropertyChanged("Password");
                this.OnPasswordChanged();
            }
        }
        private string _Password;
        partial void OnPasswordChanging(string value);
        partial void OnPasswordChanged();
        /// <summary>
        /// There are no comments for Groups in the schema.
        /// </summary>
        [global::System.Data.Objects.DataClasses.EdmRelationshipNavigationPropertyAttribute("Users", "GroupUser", "Group")]
        [global::System.Xml.Serialization.XmlIgnoreAttribute()]
        [global::System.Xml.Serialization.SoapIgnoreAttribute()]
        [global::System.Runtime.Serialization.DataMemberAttribute()]
        public global::System.Data.Objects.DataClasses.EntityCollection<Group> Groups
        {
            get
            {
                return ((global::System.Data.Objects.DataClasses.IEntityWithRelationships)(this)).RelationshipManager.GetRelatedCollection<Group>("Users.GroupUser", "Group");
            }
            set
            {
                if ((value != null))
                {
                    ((global::System.Data.Objects.DataClasses.IEntityWithRelationships)(this)).RelationshipManager.InitializeRelatedCollection<Group>("Users.GroupUser", "Group", value);
                }
            }
        }
    }
    /// <summary>
    /// There are no comments for Users.Group in the schema.
    /// </summary>
    /// <KeyProperties>
    /// Id
    /// </KeyProperties>
    [global::System.Data.Objects.DataClasses.EdmEntityTypeAttribute(NamespaceName="Users", Name="Group")]
    [global::System.Runtime.Serialization.DataContractAttribute(IsReference=true)]
    [global::System.Serializable()]
    public partial class Group : global::System.Data.Objects.DataClasses.EntityObject
    {
        /// <summary>
        /// Create a new Group object.
        /// </summary>
        /// <param name="id">Initial value of Id.</param>
        /// <param name="description">Initial value of Description.</param>
        public static Group CreateGroup(global::System.Guid id, string description)
        {
            Group group = new Group();
            group.Id = id;
            group.Description = description;
            return group;
        }
        /// <summary>
        /// There are no comments for Property Id in the schema.
        /// </summary>
        [global::System.Data.Objects.DataClasses.EdmScalarPropertyAttribute(EntityKeyProperty=true, IsNullable=false)]
        [global::System.Runtime.Serialization.DataMemberAttribute()]
        public global::System.Guid Id
        {
            get
            {
                return this._Id;
            }
            set
            {
                this.OnIdChanging(value);
                this.ReportPropertyChanging("Id");
                this._Id = global::System.Data.Objects.DataClasses.StructuralObject.SetValidValue(value);
                this.ReportPropertyChanged("Id");
                this.OnIdChanged();
            }
        }
        private global::System.Guid _Id;
        partial void OnIdChanging(global::System.Guid value);
        partial void OnIdChanged();
        /// <summary>
        /// There are no comments for Property Description in the schema.
        /// </summary>
        [global::System.Data.Objects.DataClasses.EdmScalarPropertyAttribute(IsNullable=false)]
        [global::System.Runtime.Serialization.DataMemberAttribute()]
        public string Description
        {
            get
            {
                return this._Description;
            }
            set
            {
                this.OnDescriptionChanging(value);
                this.ReportPropertyChanging("Description");
                this._Description = global::System.Data.Objects.DataClasses.StructuralObject.SetValidValue(value, false);
                this.ReportPropertyChanged("Description");
                this.OnDescriptionChanged();
            }
        }
        private string _Description;
        partial void OnDescriptionChanging(string value);
        partial void OnDescriptionChanged();
        /// <summary>
        /// There are no comments for Users in the schema.
        /// </summary>
        [global::System.Data.Objects.DataClasses.EdmRelationshipNavigationPropertyAttribute("Users", "GroupUser", "User")]
        [global::System.Xml.Serialization.XmlIgnoreAttribute()]
        [global::System.Xml.Serialization.SoapIgnoreAttribute()]
        [global::System.Runtime.Serialization.DataMemberAttribute()]
        public global::System.Data.Objects.DataClasses.EntityCollection<User> Users
        {
            get
            {
                return ((global::System.Data.Objects.DataClasses.IEntityWithRelationships)(this)).RelationshipManager.GetRelatedCollection<User>("Users.GroupUser", "User");
            }
            set
            {
                if ((value != null))
                {
                    ((global::System.Data.Objects.DataClasses.IEntityWithRelationships)(this)).RelationshipManager.InitializeRelatedCollection<User>("Users.GroupUser", "User", value);
                }
            }
        }
    }
}

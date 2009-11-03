-- --------------------------------------------------
-- Date Created: 10/21/2009 17:33:53
-- Generated from EDMX file: C:\Users\davil\Documents\Visual Studio 10\Projects\Mumble.Web.StarterKit\Mumble.Web.StarterKit\Models\UsersContainer.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER ON;
SET ANSI_NULLS ON;
GO

USE [TestDB]
GO
IF SCHEMA_ID('dbo') IS NULL EXECUTE('CREATE SCHEMA [dbo]')
GO

-- --------------------------------------------------
-- Dropping existing FK constraints
-- --------------------------------------------------

IF OBJECT_ID('dbo.FK_GroupUser_Group', 'F') IS NOT NULL
    ALTER TABLE [dbo].[GroupUser] DROP CONSTRAINT [FK_GroupUser_Group]
GO
IF OBJECT_ID('dbo.FK_GroupUser_User', 'F') IS NOT NULL
    ALTER TABLE [dbo].[GroupUser] DROP CONSTRAINT [FK_GroupUser_User]
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL
    DROP TABLE [dbo].[Users];
GO
IF OBJECT_ID('dbo.Groups', 'U') IS NOT NULL
    DROP TABLE [dbo].[Groups];
GO
IF OBJECT_ID('dbo.GroupUser', 'U') IS NOT NULL
    DROP TABLE [dbo].[GroupUser];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Users'
CREATE TABLE [dbo].[Users] (
    [Id] uniqueidentifier  NOT NULL,
    [FirstName] nvarchar(max)  NULL,
    [LastName] nvarchar(max)  NULL,
    [Address] nvarchar(max)  NULL,
    [City] nvarchar(max)  NULL,
    [Email] nvarchar(max)  NOT NULL,
    [Password] nvarchar(max)  NOT NULL
);
GO
-- Creating table 'Groups'
CREATE TABLE [dbo].[Groups] (
    [Id] uniqueidentifier  NOT NULL,
    [Description] nvarchar(max)  NOT NULL
);
GO
-- Creating table 'GroupUser'
CREATE TABLE [dbo].[GroupUser] (
    [Groups_Id] uniqueidentifier  NOT NULL,
    [Users_Id] uniqueidentifier  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all Primary Key Constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Users'
ALTER TABLE [dbo].[Users] WITH NOCHECK
ADD CONSTRAINT [PK_Users]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'Groups'
ALTER TABLE [dbo].[Groups] WITH NOCHECK
ADD CONSTRAINT [PK_Groups]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Groups_Id], [Users_Id] in table 'GroupUser'
ALTER TABLE [dbo].[GroupUser] WITH NOCHECK
ADD CONSTRAINT [PK_GroupUser]
    PRIMARY KEY NONCLUSTERED ([Groups_Id], [Users_Id] ASC)
    ON [PRIMARY]
GO

-- --------------------------------------------------
-- Creating all Foreign Key Constraints
-- --------------------------------------------------

-- Creating foreign key on [Groups_Id] in table 'GroupUser'
ALTER TABLE [dbo].[GroupUser] WITH NOCHECK
ADD CONSTRAINT [FK_GroupUser_Group]
    FOREIGN KEY ([Groups_Id])
    REFERENCES [dbo].[Groups]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [Users_Id] in table 'GroupUser'
ALTER TABLE [dbo].[GroupUser] WITH NOCHECK
ADD CONSTRAINT [FK_GroupUser_User]
    FOREIGN KEY ([Users_Id])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------


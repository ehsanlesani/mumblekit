
-- --------------------------------------------------
-- Date Created: 01/26/2010 20:17:27
-- Generated from EDMX file: C:\Users\davil\Documents\Visual Studio 10\Projects\Timerou\Timerou\Models\TimerouContainer.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
SET ANSI_NULLS ON;
GO

USE [Timerou]
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]')
GO

-- --------------------------------------------------
-- Dropping existing FK constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_GroupUser_Group]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[GroupUser] DROP CONSTRAINT [FK_GroupUser_Group]
GO
IF OBJECT_ID(N'[dbo].[FK_GroupUser_User]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[GroupUser] DROP CONSTRAINT [FK_GroupUser_User]
GO
IF OBJECT_ID(N'[dbo].[FK_CommentUser]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Comments] DROP CONSTRAINT [FK_CommentUser]
GO
IF OBJECT_ID(N'[dbo].[FK_TaggedObjectTag]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Tags] DROP CONSTRAINT [FK_TaggedObjectTag]
GO
IF OBJECT_ID(N'[dbo].[FK_SocialObjectComment]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Comments] DROP CONSTRAINT [FK_SocialObjectComment]
GO
IF OBJECT_ID(N'[dbo].[FK_CommentComment]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Comments] DROP CONSTRAINT [FK_CommentComment]
GO
IF OBJECT_ID(N'[dbo].[FK_UserPicture]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[MapObjects_Picture] DROP CONSTRAINT [FK_UserPicture]
GO
IF OBJECT_ID(N'[dbo].[FK_UserHistoricEvent]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[MapObjects_HistoricEvent] DROP CONSTRAINT [FK_UserHistoricEvent]
GO
IF OBJECT_ID(N'[dbo].[FK_Picture_inherits_MapObject]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[MapObjects_Picture] DROP CONSTRAINT [FK_Picture_inherits_MapObject]
GO
IF OBJECT_ID(N'[dbo].[FK_HistoricEvent_inherits_MapObject]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[MapObjects_HistoricEvent] DROP CONSTRAINT [FK_HistoricEvent_inherits_MapObject]
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Users]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Users];
GO
IF OBJECT_ID(N'[dbo].[Groups]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Groups];
GO
IF OBJECT_ID(N'[dbo].[MapObjects]', 'U') IS NOT NULL
    DROP TABLE [dbo].[MapObjects];
GO
IF OBJECT_ID(N'[dbo].[Tags]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Tags];
GO
IF OBJECT_ID(N'[dbo].[Comments]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Comments];
GO
IF OBJECT_ID(N'[dbo].[MapObjects_Picture]', 'U') IS NOT NULL
    DROP TABLE [dbo].[MapObjects_Picture];
GO
IF OBJECT_ID(N'[dbo].[MapObjects_HistoricEvent]', 'U') IS NOT NULL
    DROP TABLE [dbo].[MapObjects_HistoricEvent];
GO
IF OBJECT_ID(N'[dbo].[GroupUser]', 'U') IS NOT NULL
    DROP TABLE [dbo].[GroupUser];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Users'
CREATE TABLE [dbo].[Users] (
    [Id] uniqueidentifier  NOT NULL,
    [FirstName] nvarchar(max)  NOT NULL,
    [LastName] nvarchar(max)  NOT NULL,
    [Address] nvarchar(max)  NULL,
    [Email] nvarchar(max)  NOT NULL,
    [Password] nvarchar(max)  NOT NULL,
    [Lat] real  NULL,
    [Lng] real  NULL,
    [Culture] nvarchar(max)  NOT NULL
);
GO
-- Creating table 'Groups'
CREATE TABLE [dbo].[Groups] (
    [Id] uniqueidentifier  NOT NULL,
    [Description] nvarchar(max)  NOT NULL
);
GO
-- Creating table 'MapObjects'
CREATE TABLE [dbo].[MapObjects] (
    [Id] uniqueidentifier  NOT NULL,
    [Views] int  NOT NULL,
    [Created] datetime  NOT NULL,
    [Lat] real  NOT NULL,
    [Lng] real  NOT NULL,
    [Country] nvarchar(max)  NULL,
    [PostalCode] nvarchar(max)  NULL,
    [City] nvarchar(max)  NULL,
    [Region] nvarchar(max)  NULL,
    [Address] nvarchar(max)  NULL,
    [Province] nvarchar(max)  NULL
);
GO
-- Creating table 'Tags'
CREATE TABLE [dbo].[Tags] (
    [Id] uniqueidentifier  NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [TaggedObjectTag_Tag_Id] uniqueidentifier  NULL
);
GO
-- Creating table 'Comments'
CREATE TABLE [dbo].[Comments] (
    [Id] int  NOT NULL,
    [Created] datetime  NOT NULL,
    [Body] nvarchar(max)  NOT NULL,
    [User_Id] uniqueidentifier  NULL,
    [SocialObjectComment_Comment_Id] uniqueidentifier  NULL,
    [Parent_Id] int  NULL
);
GO
-- Creating table 'MapObjects_Picture'
CREATE TABLE [dbo].[MapObjects_Picture] (
    [Title] nvarchar(max)  NOT NULL,
    [Body] nvarchar(max)  NOT NULL,
    [Date] nvarchar(max)  NOT NULL,
    [Height] int  NULL,
    [Width] int  NULL,
    [Id] uniqueidentifier  NOT NULL,
    [User_Id] uniqueidentifier  NULL
);
GO
-- Creating table 'MapObjects_HistoricEvent'
CREATE TABLE [dbo].[MapObjects_HistoricEvent] (
    [Date] nvarchar(max)  NOT NULL,
    [Title] nvarchar(max)  NOT NULL,
    [Body] nvarchar(max)  NOT NULL,
    [Id] uniqueidentifier  NOT NULL,
    [User_Id] uniqueidentifier  NOT NULL
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
-- Creating primary key on [Id] in table 'MapObjects'
ALTER TABLE [dbo].[MapObjects] WITH NOCHECK 
ADD CONSTRAINT [PK_MapObjects]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'Tags'
ALTER TABLE [dbo].[Tags] WITH NOCHECK 
ADD CONSTRAINT [PK_Tags]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'Comments'
ALTER TABLE [dbo].[Comments] WITH NOCHECK 
ADD CONSTRAINT [PK_Comments]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'MapObjects_Picture'
ALTER TABLE [dbo].[MapObjects_Picture] WITH NOCHECK 
ADD CONSTRAINT [PK_MapObjects_Picture]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'MapObjects_HistoricEvent'
ALTER TABLE [dbo].[MapObjects_HistoricEvent] WITH NOCHECK 
ADD CONSTRAINT [PK_MapObjects_HistoricEvent]
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
-- Creating foreign key on [User_Id] in table 'Comments'
ALTER TABLE [dbo].[Comments] WITH NOCHECK 
ADD CONSTRAINT [FK_CommentUser]
    FOREIGN KEY ([User_Id])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [TaggedObjectTag_Tag_Id] in table 'Tags'
ALTER TABLE [dbo].[Tags] WITH NOCHECK 
ADD CONSTRAINT [FK_TaggedObjectTag]
    FOREIGN KEY ([TaggedObjectTag_Tag_Id])
    REFERENCES [dbo].[MapObjects]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [SocialObjectComment_Comment_Id] in table 'Comments'
ALTER TABLE [dbo].[Comments] WITH NOCHECK 
ADD CONSTRAINT [FK_SocialObjectComment]
    FOREIGN KEY ([SocialObjectComment_Comment_Id])
    REFERENCES [dbo].[MapObjects]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [Parent_Id] in table 'Comments'
ALTER TABLE [dbo].[Comments] WITH NOCHECK 
ADD CONSTRAINT [FK_CommentComment]
    FOREIGN KEY ([Parent_Id])
    REFERENCES [dbo].[Comments]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [User_Id] in table 'MapObjects_Picture'
ALTER TABLE [dbo].[MapObjects_Picture] WITH NOCHECK 
ADD CONSTRAINT [FK_UserPicture]
    FOREIGN KEY ([User_Id])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [User_Id] in table 'MapObjects_HistoricEvent'
ALTER TABLE [dbo].[MapObjects_HistoricEvent] WITH NOCHECK 
ADD CONSTRAINT [FK_UserHistoricEvent]
    FOREIGN KEY ([User_Id])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [Id] in table 'MapObjects_Picture'
ALTER TABLE [dbo].[MapObjects_Picture] WITH NOCHECK 
ADD CONSTRAINT [FK_Picture_inherits_MapObject]
    FOREIGN KEY ([Id])
    REFERENCES [dbo].[MapObjects]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [Id] in table 'MapObjects_HistoricEvent'
ALTER TABLE [dbo].[MapObjects_HistoricEvent] WITH NOCHECK 
ADD CONSTRAINT [FK_HistoricEvent_inherits_MapObject]
    FOREIGN KEY ([Id])
    REFERENCES [dbo].[MapObjects]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------
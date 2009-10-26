-- --------------------------------------------------
-- Date Created: 10/25/2009 23:56:26
-- Generated from EDMX file: C:\Users\geek\Documents\Visual Studio 10\Projects\Mumble.Web.StarterKit\Mumble.Web.StarterKit\Mumble.Web.StarterKit\Models\StarterKitContainer.edmx
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

IF OBJECT_ID('dbo.FK_Accommodations_AccommodationTypes', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Accommodations] DROP CONSTRAINT [FK_Accommodations_AccommodationTypes]
GO
IF OBJECT_ID('dbo.FK_PageAttachment', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Attachments] DROP CONSTRAINT [FK_PageAttachment]
GO
IF OBJECT_ID('dbo.FK_SectionPage', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Pages] DROP CONSTRAINT [FK_SectionPage]
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID('dbo.Accommodations', 'U') IS NOT NULL
    DROP TABLE [dbo].[Accommodations];
GO
IF OBJECT_ID('dbo.AccommodationTypes', 'U') IS NOT NULL
    DROP TABLE [dbo].[AccommodationTypes];
GO
IF OBJECT_ID('dbo.Attachments', 'U') IS NOT NULL
    DROP TABLE [dbo].[Attachments];
GO
IF OBJECT_ID('dbo.Pages', 'U') IS NOT NULL
    DROP TABLE [dbo].[Pages];
GO
IF OBJECT_ID('dbo.Sections', 'U') IS NOT NULL
    DROP TABLE [dbo].[Sections];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Attachments'
CREATE TABLE [dbo].[Attachments] (
    [Id] uniqueidentifier  NOT NULL,
    [Title] varchar(50)  NULL,
    [Description] varchar(50)  NULL,
    [Path] varchar(max)  NULL,
    [Page_Id] uniqueidentifier  NULL
);
GO
-- Creating table 'Pages'
CREATE TABLE [dbo].[Pages] (
    [Id] uniqueidentifier  NOT NULL,
    [Description] nvarchar(max)  NULL,
    [Priority] int  NULL,
    [Visible] bit  NULL,
    [ValidFrom] datetime  NULL,
    [ValidTo] datetime  NULL,
    [Body] nvarchar(max)  NULL,
    [Section_Id] uniqueidentifier  NULL
);
GO
-- Creating table 'Sections'
CREATE TABLE [dbo].[Sections] (
    [Id] uniqueidentifier  NOT NULL,
    [Description] varchar(50)  NULL,
    [Priority] int  NULL,
    [Visible] bit  NULL,
    [ValidFrom] datetime  NULL,
    [ValidTo] datetime  NULL
);
GO
-- Creating table 'Accommodations'
CREATE TABLE [dbo].[Accommodations] (
    [Id] uniqueidentifier  NOT NULL,
    [Name] nvarchar(max)  NULL,
    [AccommodationType_Id] uniqueidentifier  NOT NULL
);
GO
-- Creating table 'AccommodationTypes'
CREATE TABLE [dbo].[AccommodationTypes] (
    [Id] uniqueidentifier  NOT NULL,
    [Name] nvarchar(max)  NULL
);
GO

-- --------------------------------------------------
-- Creating all Primary Key Constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Attachments'
ALTER TABLE [dbo].[Attachments] WITH NOCHECK
ADD CONSTRAINT [PK_Attachments]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'Pages'
ALTER TABLE [dbo].[Pages] WITH NOCHECK
ADD CONSTRAINT [PK_Pages]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'Sections'
ALTER TABLE [dbo].[Sections] WITH NOCHECK
ADD CONSTRAINT [PK_Sections]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'Accommodations'
ALTER TABLE [dbo].[Accommodations] WITH NOCHECK
ADD CONSTRAINT [PK_Accommodations]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'AccommodationTypes'
ALTER TABLE [dbo].[AccommodationTypes] WITH NOCHECK
ADD CONSTRAINT [PK_AccommodationTypes]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO

-- --------------------------------------------------
-- Creating all Foreign Key Constraints
-- --------------------------------------------------

-- Creating foreign key on [Page_Id] in table 'Attachments'
ALTER TABLE [dbo].[Attachments] WITH NOCHECK
ADD CONSTRAINT [FK_PageAttachment]
    FOREIGN KEY ([Page_Id])
    REFERENCES [dbo].[Pages]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [Section_Id] in table 'Pages'
ALTER TABLE [dbo].[Pages] WITH NOCHECK
ADD CONSTRAINT [FK_SectionPage]
    FOREIGN KEY ([Section_Id])
    REFERENCES [dbo].[Sections]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [AccommodationType_Id] in table 'Accommodations'
ALTER TABLE [dbo].[Accommodations] WITH NOCHECK
ADD CONSTRAINT [FK_Accommodations_AccommodationTypes]
    FOREIGN KEY ([AccommodationType_Id])
    REFERENCES [dbo].[AccommodationTypes]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------


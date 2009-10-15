-- --------------------------------------------------
-- Date Created: 10/14/2009 17:37:24
-- Generated from EDMX file: C:\Users\davil\Documents\Visual Studio 10\Projects\MumbleKit\MumbleKit\Models\MumbleKitContainer.edmx
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

IF OBJECT_ID('dbo.FK_SectionPage', 'F') IS NOT NULL
    ALTER TABLE [dbo].[PageSet] DROP CONSTRAINT [FK_SectionPage]
GO
IF OBJECT_ID('dbo.FK_PageAttachment', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Attachments] DROP CONSTRAINT [FK_PageAttachment]
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID('dbo.Attachments', 'U') IS NOT NULL
    DROP TABLE [dbo].[Attachments];
GO
IF OBJECT_ID('dbo.SectionSet', 'U') IS NOT NULL
    DROP TABLE [dbo].[SectionSet];
GO
IF OBJECT_ID('dbo.PageSet', 'U') IS NOT NULL
    DROP TABLE [dbo].[PageSet];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Attachments'
CREATE TABLE [dbo].[Attachments] (
    [Id] uniqueidentifier  NOT NULL,
    [Title] nvarchar(max)  NOT NULL,
    [Description] nvarchar(max)  NOT NULL,
    [Path] nvarchar(max)  NOT NULL,
    [Page_Id] uniqueidentifier  NULL
);
GO
-- Creating table 'SectionSet'
CREATE TABLE [dbo].[SectionSet] (
    [Id] uniqueidentifier  NOT NULL,
    [Description] nvarchar(max)  NOT NULL,
    [Priority] int  NOT NULL,
    [Visible] bit  NOT NULL,
    [ValidFrom] datetime  NOT NULL,
    [ValidTo] datetime  NOT NULL
);
GO
-- Creating table 'Pages'
CREATE TABLE [dbo].[Pages] (
    [Id] uniqueidentifier  NOT NULL,
    [Description] nvarchar(max)  NOT NULL,
    [Priority] int  NOT NULL,
    [Visible] bit  NOT NULL,
    [ValidFrom] datetime  NOT NULL,
    [ValidTo] datetime  NOT NULL,
    [Body] nvarchar(max)  NOT NULL,
    [Section_Id] uniqueidentifier  NULL
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
-- Creating primary key on [Id] in table 'SectionSet'
ALTER TABLE [dbo].[SectionSet] WITH NOCHECK
ADD CONSTRAINT [PK_SectionSet]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'Pages'
ALTER TABLE [dbo].[Pages] WITH NOCHECK
ADD CONSTRAINT [PK_Pages]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO

-- --------------------------------------------------
-- Creating all Foreign Key Constraints
-- --------------------------------------------------

-- Creating foreign key on [Section_Id] in table 'Pages'
ALTER TABLE [dbo].[Pages] WITH NOCHECK
ADD CONSTRAINT [FK_SectionPage]
    FOREIGN KEY ([Section_Id])
    REFERENCES [dbo].[SectionSet]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [Page_Id] in table 'Attachments'
ALTER TABLE [dbo].[Attachments] WITH NOCHECK
ADD CONSTRAINT [FK_PageAttachment]
    FOREIGN KEY ([Page_Id])
    REFERENCES [dbo].[Pages]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------



-- --------------------------------------------------
-- Date Created: 01/19/2010 14:17:07
-- Generated from EDMX file: C:\Users\davil\Documents\Visual Studio 10\Projects\AgriturismiHolidays\AgriturismiHolidays\Models\StarterKitContainer.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
SET ANSI_NULLS ON;
GO

USE [Agriturismi]
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]')
GO

-- --------------------------------------------------
-- Dropping existing FK constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK_AccommodationRooms_Accommodations]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Rooms] DROP CONSTRAINT [FK_AccommodationRooms_Accommodations]
GO
IF OBJECT_ID(N'[dbo].[FK_Accommodations_AccommodationTypes]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Accommodations] DROP CONSTRAINT [FK_Accommodations_AccommodationTypes]
GO
IF OBJECT_ID(N'[dbo].[FK_Accommodations_Municipalities]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Accommodations] DROP CONSTRAINT [FK_Accommodations_Municipalities]
GO
IF OBJECT_ID(N'[dbo].[FK_Attachments_Accommodations]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Attachments] DROP CONSTRAINT [FK_Attachments_Accommodations]
GO
IF OBJECT_ID(N'[dbo].[FK_Municipalities_Provinces]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Municipalities] DROP CONSTRAINT [FK_Municipalities_Provinces]
GO
IF OBJECT_ID(N'[dbo].[FK_PageAttachment]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Attachments] DROP CONSTRAINT [FK_PageAttachment]
GO
IF OBJECT_ID(N'[dbo].[FK_Provinces_Region]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Provinces] DROP CONSTRAINT [FK_Provinces_Region]
GO
IF OBJECT_ID(N'[dbo].[FK_RoomPriceList_PriceListEntries]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[RoomPriceList] DROP CONSTRAINT [FK_RoomPriceList_PriceListEntries]
GO
IF OBJECT_ID(N'[dbo].[FK_RoomPriceList_PriceListSeasons]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[RoomPriceList] DROP CONSTRAINT [FK_RoomPriceList_PriceListSeasons]
GO
IF OBJECT_ID(N'[dbo].[FK_RoomPriceList_Rooms]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[RoomPriceList] DROP CONSTRAINT [FK_RoomPriceList_Rooms]
GO
IF OBJECT_ID(N'[dbo].[FK_SectionPage]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Pages] DROP CONSTRAINT [FK_SectionPage]
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Accommodations]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Accommodations];
GO
IF OBJECT_ID(N'[dbo].[AccommodationTypes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[AccommodationTypes];
GO
IF OBJECT_ID(N'[dbo].[Attachments]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Attachments];
GO
IF OBJECT_ID(N'[dbo].[Municipalities]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Municipalities];
GO
IF OBJECT_ID(N'[dbo].[Pages]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Pages];
GO
IF OBJECT_ID(N'[dbo].[PriceListEntries]', 'U') IS NOT NULL
    DROP TABLE [dbo].[PriceListEntries];
GO
IF OBJECT_ID(N'[dbo].[PriceListSeasons]', 'U') IS NOT NULL
    DROP TABLE [dbo].[PriceListSeasons];
GO
IF OBJECT_ID(N'[dbo].[Provinces]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Provinces];
GO
IF OBJECT_ID(N'[dbo].[Region]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Region];
GO
IF OBJECT_ID(N'[dbo].[RoomPriceList]', 'U') IS NOT NULL
    DROP TABLE [dbo].[RoomPriceList];
GO
IF OBJECT_ID(N'[dbo].[Rooms]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Rooms];
GO
IF OBJECT_ID(N'[dbo].[Sections]', 'U') IS NOT NULL
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
    [Page_Id] uniqueidentifier  NULL,
    [Accommodations_Id] uniqueidentifier  NULL
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
    [Description] nvarchar(max)  NULL,
    [Street] nvarchar(max)  NULL,
    [Cap] nvarchar(max)  NULL,
    [ShowMap] bit  NULL,
    [WhereWeAre] nvarchar(max)  NULL,
    [Email] nvarchar(max)  NULL,
    [Quality] int  NULL,
    [AccommodationType_Id] uniqueidentifier  NOT NULL,
    [Municipalities_Id] uniqueidentifier  NULL
);
GO
-- Creating table 'AccommodationTypes'
CREATE TABLE [dbo].[AccommodationTypes] (
    [Id] uniqueidentifier  NOT NULL,
    [Name] nvarchar(max)  NULL
);
GO
-- Creating table 'Municipalities'
CREATE TABLE [dbo].[Municipalities] (
    [Id] uniqueidentifier  NOT NULL,
    [Name] nvarchar(150)  NULL,
    [Province_Id] uniqueidentifier  NOT NULL
);
GO
-- Creating table 'Provinces'
CREATE TABLE [dbo].[Provinces] (
    [Id] uniqueidentifier  NOT NULL,
    [Initial] nchar(2)  NULL,
    [Name] nvarchar(100)  NULL,
    [Region_Id] uniqueidentifier  NOT NULL
);
GO
-- Creating table 'Regions'
CREATE TABLE [dbo].[Regions] (
    [Id] uniqueidentifier  NOT NULL,
    [Description] nvarchar(max)  NULL
);
GO
-- Creating table 'PriceListEntries'
CREATE TABLE [dbo].[PriceListEntries] (
    [Id] uniqueidentifier  NOT NULL,
    [Description] nvarchar(max)  NULL
);
GO
-- Creating table 'PriceListSeasons'
CREATE TABLE [dbo].[PriceListSeasons] (
    [Id] uniqueidentifier  NOT NULL,
    [PeriodStart] datetime  NULL,
    [PeriodEnd] datetime  NULL,
    [Description] nvarchar(max)  NULL
);
GO
-- Creating table 'RoomPriceList'
CREATE TABLE [dbo].[RoomPriceList] (
    [Id] uniqueidentifier  NOT NULL,
    [Price] decimal(18,0)  NULL,
    [PriceListEntries_Id] uniqueidentifier  NULL,
    [PriceListSeasons_Id] uniqueidentifier  NULL,
    [Rooms_Id] uniqueidentifier  NULL
);
GO
-- Creating table 'Rooms'
CREATE TABLE [dbo].[Rooms] (
    [Id] uniqueidentifier  NOT NULL,
    [Name] nvarchar(max)  NULL,
    [Text] nvarchar(max)  NULL,
    [Persons] smallint  NULL,
    [Accommodations_Id] uniqueidentifier  NULL
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
-- Creating primary key on [Id] in table 'Municipalities'
ALTER TABLE [dbo].[Municipalities] WITH NOCHECK 
ADD CONSTRAINT [PK_Municipalities]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'Provinces'
ALTER TABLE [dbo].[Provinces] WITH NOCHECK 
ADD CONSTRAINT [PK_Provinces]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'Regions'
ALTER TABLE [dbo].[Regions] WITH NOCHECK 
ADD CONSTRAINT [PK_Regions]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'PriceListEntries'
ALTER TABLE [dbo].[PriceListEntries] WITH NOCHECK 
ADD CONSTRAINT [PK_PriceListEntries]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'PriceListSeasons'
ALTER TABLE [dbo].[PriceListSeasons] WITH NOCHECK 
ADD CONSTRAINT [PK_PriceListSeasons]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'RoomPriceList'
ALTER TABLE [dbo].[RoomPriceList] WITH NOCHECK 
ADD CONSTRAINT [PK_RoomPriceList]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'Rooms'
ALTER TABLE [dbo].[Rooms] WITH NOCHECK 
ADD CONSTRAINT [PK_Rooms]
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
-- Creating foreign key on [Province_Id] in table 'Municipalities'
ALTER TABLE [dbo].[Municipalities] WITH NOCHECK 
ADD CONSTRAINT [FK_Municipalities_Provinces]
    FOREIGN KEY ([Province_Id])
    REFERENCES [dbo].[Provinces]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [Region_Id] in table 'Provinces'
ALTER TABLE [dbo].[Provinces] WITH NOCHECK 
ADD CONSTRAINT [FK_Provinces_Region]
    FOREIGN KEY ([Region_Id])
    REFERENCES [dbo].[Regions]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [Accommodations_Id] in table 'Attachments'
ALTER TABLE [dbo].[Attachments] WITH NOCHECK 
ADD CONSTRAINT [FK_Attachments_Accommodations]
    FOREIGN KEY ([Accommodations_Id])
    REFERENCES [dbo].[Accommodations]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [Accommodations_Id] in table 'Rooms'
ALTER TABLE [dbo].[Rooms] WITH NOCHECK 
ADD CONSTRAINT [FK_AccommodationRooms_Accommodations]
    FOREIGN KEY ([Accommodations_Id])
    REFERENCES [dbo].[Accommodations]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [PriceListEntries_Id] in table 'RoomPriceList'
ALTER TABLE [dbo].[RoomPriceList] WITH NOCHECK 
ADD CONSTRAINT [FK_RoomPriceList_PriceListEntries]
    FOREIGN KEY ([PriceListEntries_Id])
    REFERENCES [dbo].[PriceListEntries]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [PriceListSeasons_Id] in table 'RoomPriceList'
ALTER TABLE [dbo].[RoomPriceList] WITH NOCHECK 
ADD CONSTRAINT [FK_RoomPriceList_PriceListSeasons]
    FOREIGN KEY ([PriceListSeasons_Id])
    REFERENCES [dbo].[PriceListSeasons]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [Rooms_Id] in table 'RoomPriceList'
ALTER TABLE [dbo].[RoomPriceList] WITH NOCHECK 
ADD CONSTRAINT [FK_RoomPriceList_Rooms]
    FOREIGN KEY ([Rooms_Id])
    REFERENCES [dbo].[Rooms]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [Municipalities_Id] in table 'Accommodations'
ALTER TABLE [dbo].[Accommodations] WITH NOCHECK 
ADD CONSTRAINT [FK_Accommodations_Municipalities]
    FOREIGN KEY ([Municipalities_Id])
    REFERENCES [dbo].[Municipalities]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------
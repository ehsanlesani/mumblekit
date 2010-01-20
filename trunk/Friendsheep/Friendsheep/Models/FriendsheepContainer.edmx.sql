
-- --------------------------------------------------
-- Date Created: 01/14/2010 18:28:18
-- Generated from EDMX file: C:\Users\davil\Documents\Visual Studio 10\Projects\Friendsheep\Friendsheep\Models\FriendsheepContainer.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
SET ANSI_NULLS ON;
GO

USE [Friendsheep]
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
IF OBJECT_ID(N'[dbo].[FK_UserState]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Users] DROP CONSTRAINT [FK_UserState]
GO
IF OBJECT_ID(N'[dbo].[FK_CommentUser]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Comments] DROP CONSTRAINT [FK_CommentUser]
GO
IF OBJECT_ID(N'[dbo].[FK_TaggedObjectTag]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Tags] DROP CONSTRAINT [FK_TaggedObjectTag]
GO
IF OBJECT_ID(N'[dbo].[FK_UserPicture]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SocialObjects_Picture] DROP CONSTRAINT [FK_UserPicture]
GO
IF OBJECT_ID(N'[dbo].[FK_SocialObjectComment]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Comments] DROP CONSTRAINT [FK_SocialObjectComment]
GO
IF OBJECT_ID(N'[dbo].[FK_SocialObjectVote]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Votes] DROP CONSTRAINT [FK_SocialObjectVote]
GO
IF OBJECT_ID(N'[dbo].[FK_VoteUser]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Votes] DROP CONSTRAINT [FK_VoteUser]
GO
IF OBJECT_ID(N'[dbo].[FK_UserPost]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SocialObjects_Post] DROP CONSTRAINT [FK_UserPost]
GO
IF OBJECT_ID(N'[dbo].[FK_PrivateMessageUser]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[PrivateMessages] DROP CONSTRAINT [FK_PrivateMessageUser]
GO
IF OBJECT_ID(N'[dbo].[FK_PrivateMessageUser1]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Users] DROP CONSTRAINT [FK_PrivateMessageUser1]
GO
IF OBJECT_ID(N'[dbo].[FK_CommentComment]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Comments] DROP CONSTRAINT [FK_CommentComment]
GO
IF OBJECT_ID(N'[dbo].[FK_UserStatus]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SocialObjects_Mood] DROP CONSTRAINT [FK_UserStatus]
GO
IF OBJECT_ID(N'[dbo].[FK_FlockUser]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Users] DROP CONSTRAINT [FK_FlockUser]
GO
IF OBJECT_ID(N'[dbo].[FK_FlockUser1]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Users] DROP CONSTRAINT [FK_FlockUser1]
GO
IF OBJECT_ID(N'[dbo].[FK_FlockChat]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Chats] DROP CONSTRAINT [FK_FlockChat]
GO
IF OBJECT_ID(N'[dbo].[FK_FlockDog]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Users] DROP CONSTRAINT [FK_FlockDog]
GO
IF OBJECT_ID(N'[dbo].[FK_ChatUser]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Chats] DROP CONSTRAINT [FK_ChatUser]
GO
IF OBJECT_ID(N'[dbo].[FK_AlbumPicture]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SocialObjects_Picture] DROP CONSTRAINT [FK_AlbumPicture]
GO
IF OBJECT_ID(N'[dbo].[FK_UserAlbum]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Albums] DROP CONSTRAINT [FK_UserAlbum]
GO
IF OBJECT_ID(N'[dbo].[FK_UserProfilePicture]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Users] DROP CONSTRAINT [FK_UserProfilePicture]
GO
IF OBJECT_ID(N'[dbo].[FK_Picture_inherits_SocialObject]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SocialObjects_Picture] DROP CONSTRAINT [FK_Picture_inherits_SocialObject]
GO
IF OBJECT_ID(N'[dbo].[FK_Post_inherits_SocialObject]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SocialObjects_Post] DROP CONSTRAINT [FK_Post_inherits_SocialObject]
GO
IF OBJECT_ID(N'[dbo].[FK_Mood_inherits_SocialObject]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[SocialObjects_Mood] DROP CONSTRAINT [FK_Mood_inherits_SocialObject]
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
IF OBJECT_ID(N'[dbo].[Farms]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Farms];
GO
IF OBJECT_ID(N'[dbo].[SocialObjects]', 'U') IS NOT NULL
    DROP TABLE [dbo].[SocialObjects];
GO
IF OBJECT_ID(N'[dbo].[Tags]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Tags];
GO
IF OBJECT_ID(N'[dbo].[Comments]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Comments];
GO
IF OBJECT_ID(N'[dbo].[Votes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Votes];
GO
IF OBJECT_ID(N'[dbo].[PrivateMessages]', 'U') IS NOT NULL
    DROP TABLE [dbo].[PrivateMessages];
GO
IF OBJECT_ID(N'[dbo].[Flocks]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Flocks];
GO
IF OBJECT_ID(N'[dbo].[Chats]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Chats];
GO
IF OBJECT_ID(N'[dbo].[Albums]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Albums];
GO
IF OBJECT_ID(N'[dbo].[SocialObjects_Picture]', 'U') IS NOT NULL
    DROP TABLE [dbo].[SocialObjects_Picture];
GO
IF OBJECT_ID(N'[dbo].[SocialObjects_Post]', 'U') IS NOT NULL
    DROP TABLE [dbo].[SocialObjects_Post];
GO
IF OBJECT_ID(N'[dbo].[SocialObjects_Mood]', 'U') IS NOT NULL
    DROP TABLE [dbo].[SocialObjects_Mood];
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
    [City] nvarchar(max)  NULL,
    [Email] nvarchar(max)  NOT NULL,
    [Password] nvarchar(max)  NOT NULL,
    [tGender] nvarchar(max)  NOT NULL,
    [Birthday] datetime  NOT NULL,
    [LastAccess] datetime  NOT NULL,
    [Ping] datetime  NOT NULL,
    [IsOnline] bit  NOT NULL,
    [Look] real  NOT NULL,
    [Character] real  NOT NULL,
    [Culture] nvarchar(max)  NOT NULL,
    [LookWeight] int  NOT NULL,
    [Farm_Id] uniqueidentifier  NULL,
    [PrivateMessageUser1_User_Id] uniqueidentifier  NULL,
    [JoinedFlock_Id] uniqueidentifier  NULL,
    [ShepherFlock_Id] uniqueidentifier  NULL,
    [DogFlock_Id] uniqueidentifier  NULL,
    [ProfilePicture_Id] uniqueidentifier  NULL
);
GO
-- Creating table 'Groups'
CREATE TABLE [dbo].[Groups] (
    [Id] uniqueidentifier  NOT NULL,
    [Description] nvarchar(max)  NOT NULL
);
GO
-- Creating table 'Farms'
CREATE TABLE [dbo].[Farms] (
    [Id] uniqueidentifier  NOT NULL,
    [Name] nvarchar(max)  NOT NULL
);
GO
-- Creating table 'SocialObjects'
CREATE TABLE [dbo].[SocialObjects] (
    [Id] uniqueidentifier  NOT NULL,
    [Views] int  NOT NULL,
    [Created] datetime  NOT NULL
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
-- Creating table 'Votes'
CREATE TABLE [dbo].[Votes] (
    [Id] uniqueidentifier  NOT NULL,
    [Created] datetime  NOT NULL,
    [Value] int  NOT NULL,
    [Type] nvarchar(max)  NOT NULL,
    [SocialObjectVote_Vote_Id] uniqueidentifier  NULL,
    [User_Id] uniqueidentifier  NULL
);
GO
-- Creating table 'PrivateMessages'
CREATE TABLE [dbo].[PrivateMessages] (
    [Id] uniqueidentifier  NOT NULL,
    [Title] nvarchar(max)  NOT NULL,
    [Body] nvarchar(max)  NOT NULL,
    [Created] nvarchar(max)  NOT NULL,
    [FromUser_Id] uniqueidentifier  NULL
);
GO
-- Creating table 'Flocks'
CREATE TABLE [dbo].[Flocks] (
    [Id] uniqueidentifier  NOT NULL,
    [Name] nvarchar(max)  NOT NULL,
    [Topic] nvarchar(max)  NOT NULL
);
GO
-- Creating table 'Chats'
CREATE TABLE [dbo].[Chats] (
    [Id] uniqueidentifier  NOT NULL,
    [Text] nvarchar(max)  NOT NULL,
    [Created] datetime  NOT NULL,
    [FlockChat_Chat_Id] uniqueidentifier  NULL,
    [User_Id] uniqueidentifier  NULL
);
GO
-- Creating table 'Albums'
CREATE TABLE [dbo].[Albums] (
    [Id] uniqueidentifier  NOT NULL,
    [Title] nvarchar(max)  NOT NULL,
    [User_Id] uniqueidentifier  NULL
);
GO
-- Creating table 'SocialObjects_Picture'
CREATE TABLE [dbo].[SocialObjects_Picture] (
    [Description] nvarchar(max)  NOT NULL,
    [IsProfilePicture] bit  NOT NULL,
    [Height] int  NOT NULL,
    [Width] int  NOT NULL,
    [Id] uniqueidentifier  NOT NULL,
    [UserPicture_Picture_Id] uniqueidentifier  NULL,
    [Album_Id] uniqueidentifier  NULL
);
GO
-- Creating table 'SocialObjects_Post'
CREATE TABLE [dbo].[SocialObjects_Post] (
    [Title] nvarchar(max)  NOT NULL,
    [Body] nvarchar(max)  NOT NULL,
    [Id] uniqueidentifier  NOT NULL,
    [User_Id] uniqueidentifier  NULL
);
GO
-- Creating table 'SocialObjects_Mood'
CREATE TABLE [dbo].[SocialObjects_Mood] (
    [tValue] int  NOT NULL,
    [Id] uniqueidentifier  NOT NULL,
    [User_Id] uniqueidentifier  NULL
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
-- Creating primary key on [Id] in table 'Farms'
ALTER TABLE [dbo].[Farms] WITH NOCHECK 
ADD CONSTRAINT [PK_Farms]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'SocialObjects'
ALTER TABLE [dbo].[SocialObjects] WITH NOCHECK 
ADD CONSTRAINT [PK_SocialObjects]
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
-- Creating primary key on [Id] in table 'Votes'
ALTER TABLE [dbo].[Votes] WITH NOCHECK 
ADD CONSTRAINT [PK_Votes]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'PrivateMessages'
ALTER TABLE [dbo].[PrivateMessages] WITH NOCHECK 
ADD CONSTRAINT [PK_PrivateMessages]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'Flocks'
ALTER TABLE [dbo].[Flocks] WITH NOCHECK 
ADD CONSTRAINT [PK_Flocks]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'Chats'
ALTER TABLE [dbo].[Chats] WITH NOCHECK 
ADD CONSTRAINT [PK_Chats]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'Albums'
ALTER TABLE [dbo].[Albums] WITH NOCHECK 
ADD CONSTRAINT [PK_Albums]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'SocialObjects_Picture'
ALTER TABLE [dbo].[SocialObjects_Picture] WITH NOCHECK 
ADD CONSTRAINT [PK_SocialObjects_Picture]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'SocialObjects_Post'
ALTER TABLE [dbo].[SocialObjects_Post] WITH NOCHECK 
ADD CONSTRAINT [PK_SocialObjects_Post]
    PRIMARY KEY CLUSTERED ([Id] ASC)
    ON [PRIMARY]
GO
-- Creating primary key on [Id] in table 'SocialObjects_Mood'
ALTER TABLE [dbo].[SocialObjects_Mood] WITH NOCHECK 
ADD CONSTRAINT [PK_SocialObjects_Mood]
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
-- Creating foreign key on [Farm_Id] in table 'Users'
ALTER TABLE [dbo].[Users] WITH NOCHECK 
ADD CONSTRAINT [FK_UserState]
    FOREIGN KEY ([Farm_Id])
    REFERENCES [dbo].[Farms]
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
    REFERENCES [dbo].[SocialObjects]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [UserPicture_Picture_Id] in table 'SocialObjects_Picture'
ALTER TABLE [dbo].[SocialObjects_Picture] WITH NOCHECK 
ADD CONSTRAINT [FK_UserPicture]
    FOREIGN KEY ([UserPicture_Picture_Id])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [SocialObjectComment_Comment_Id] in table 'Comments'
ALTER TABLE [dbo].[Comments] WITH NOCHECK 
ADD CONSTRAINT [FK_SocialObjectComment]
    FOREIGN KEY ([SocialObjectComment_Comment_Id])
    REFERENCES [dbo].[SocialObjects]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [SocialObjectVote_Vote_Id] in table 'Votes'
ALTER TABLE [dbo].[Votes] WITH NOCHECK 
ADD CONSTRAINT [FK_SocialObjectVote]
    FOREIGN KEY ([SocialObjectVote_Vote_Id])
    REFERENCES [dbo].[SocialObjects]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [User_Id] in table 'Votes'
ALTER TABLE [dbo].[Votes] WITH NOCHECK 
ADD CONSTRAINT [FK_VoteUser]
    FOREIGN KEY ([User_Id])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [User_Id] in table 'SocialObjects_Post'
ALTER TABLE [dbo].[SocialObjects_Post] WITH NOCHECK 
ADD CONSTRAINT [FK_UserPost]
    FOREIGN KEY ([User_Id])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [FromUser_Id] in table 'PrivateMessages'
ALTER TABLE [dbo].[PrivateMessages] WITH NOCHECK 
ADD CONSTRAINT [FK_PrivateMessageUser]
    FOREIGN KEY ([FromUser_Id])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [PrivateMessageUser1_User_Id] in table 'Users'
ALTER TABLE [dbo].[Users] WITH NOCHECK 
ADD CONSTRAINT [FK_PrivateMessageUser1]
    FOREIGN KEY ([PrivateMessageUser1_User_Id])
    REFERENCES [dbo].[PrivateMessages]
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
-- Creating foreign key on [User_Id] in table 'SocialObjects_Mood'
ALTER TABLE [dbo].[SocialObjects_Mood] WITH NOCHECK 
ADD CONSTRAINT [FK_UserStatus]
    FOREIGN KEY ([User_Id])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [JoinedFlock_Id] in table 'Users'
ALTER TABLE [dbo].[Users] WITH NOCHECK 
ADD CONSTRAINT [FK_FlockUser]
    FOREIGN KEY ([JoinedFlock_Id])
    REFERENCES [dbo].[Flocks]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [ShepherFlock_Id] in table 'Users'
ALTER TABLE [dbo].[Users] WITH NOCHECK 
ADD CONSTRAINT [FK_FlockUser1]
    FOREIGN KEY ([ShepherFlock_Id])
    REFERENCES [dbo].[Flocks]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [FlockChat_Chat_Id] in table 'Chats'
ALTER TABLE [dbo].[Chats] WITH NOCHECK 
ADD CONSTRAINT [FK_FlockChat]
    FOREIGN KEY ([FlockChat_Chat_Id])
    REFERENCES [dbo].[Flocks]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [DogFlock_Id] in table 'Users'
ALTER TABLE [dbo].[Users] WITH NOCHECK 
ADD CONSTRAINT [FK_FlockDog]
    FOREIGN KEY ([DogFlock_Id])
    REFERENCES [dbo].[Flocks]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [User_Id] in table 'Chats'
ALTER TABLE [dbo].[Chats] WITH NOCHECK 
ADD CONSTRAINT [FK_ChatUser]
    FOREIGN KEY ([User_Id])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [Album_Id] in table 'SocialObjects_Picture'
ALTER TABLE [dbo].[SocialObjects_Picture] WITH NOCHECK 
ADD CONSTRAINT [FK_AlbumPicture]
    FOREIGN KEY ([Album_Id])
    REFERENCES [dbo].[Albums]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [User_Id] in table 'Albums'
ALTER TABLE [dbo].[Albums] WITH NOCHECK 
ADD CONSTRAINT [FK_UserAlbum]
    FOREIGN KEY ([User_Id])
    REFERENCES [dbo].[Users]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [ProfilePicture_Id] in table 'Users'
ALTER TABLE [dbo].[Users] WITH NOCHECK 
ADD CONSTRAINT [FK_UserProfilePicture]
    FOREIGN KEY ([ProfilePicture_Id])
    REFERENCES [dbo].[SocialObjects_Picture]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [Id] in table 'SocialObjects_Picture'
ALTER TABLE [dbo].[SocialObjects_Picture] WITH NOCHECK 
ADD CONSTRAINT [FK_Picture_inherits_SocialObject]
    FOREIGN KEY ([Id])
    REFERENCES [dbo].[SocialObjects]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [Id] in table 'SocialObjects_Post'
ALTER TABLE [dbo].[SocialObjects_Post] WITH NOCHECK 
ADD CONSTRAINT [FK_Post_inherits_SocialObject]
    FOREIGN KEY ([Id])
    REFERENCES [dbo].[SocialObjects]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO
-- Creating foreign key on [Id] in table 'SocialObjects_Mood'
ALTER TABLE [dbo].[SocialObjects_Mood] WITH NOCHECK 
ADD CONSTRAINT [FK_Mood_inherits_SocialObject]
    FOREIGN KEY ([Id])
    REFERENCES [dbo].[SocialObjects]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------
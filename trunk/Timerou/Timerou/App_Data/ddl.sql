USE [Timerou]
GO
/****** Object:  Table [dbo].[Groups]    Script Date: 02/25/2010 23:17:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Groups](
	[Id] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Groups] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 02/25/2010 23:17:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [uniqueidentifier] NOT NULL,
	[FirstName] [nvarchar](max) NOT NULL,
	[LastName] [nvarchar](max) NOT NULL,
	[Address] [nvarchar](max) NULL,
	[Email] [nvarchar](max) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
	[Lat] [float] NULL,
	[Lng] [float] NULL,
	[Culture] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Media]    Script Date: 02/25/2010 23:17:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Media](
	[Id] [uniqueidentifier] NOT NULL,
	[Views] [int] NOT NULL,
	[Created] [datetime] NOT NULL,
	[Lat] [float] NOT NULL,
	[Lng] [float] NOT NULL,
	[Year] [int] NOT NULL,
	[Country] [nvarchar](max) NULL,
	[CountryCode] [nvarchar](20) NULL,
	[PostalCode] [nvarchar](max) NULL,
	[City] [nvarchar](max) NULL,
	[Region] [nvarchar](max) NULL,
	[Address] [nvarchar](max) NULL,
	[Province] [nvarchar](max) NULL,
	[Title] [nvarchar](max) NULL,
	[Body] [text] NULL,
	[IsTemp] [bit] NULL,
	[User_Id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_MapObjects] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GroupUser]    Script Date: 02/25/2010 23:17:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GroupUser](
	[Groups_Id] [uniqueidentifier] NOT NULL,
	[Users_Id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_GroupUser] PRIMARY KEY NONCLUSTERED 
(
	[Groups_Id] ASC,
	[Users_Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Videos]    Script Date: 02/25/2010 23:17:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Videos](
	[Id] [uniqueidentifier] NOT NULL,
	[YouTubeId] [nvarchar](20) NULL,
 CONSTRAINT [PK_Videos] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Comments]    Script Date: 02/25/2010 23:17:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Comments](
	[Id] [uniqueidentifier] NOT NULL,
	[Body] [text] NOT NULL,
	[Created] [datetime] NOT NULL,
	[User_Id] [uniqueidentifier] NOT NULL,
	[MapObject_Id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Comments] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tags]    Script Date: 02/25/2010 23:17:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tags](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](max) NOT NULL,
	[MapObject_Id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Tags] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Pictures]    Script Date: 02/25/2010 23:17:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pictures](
	[Id] [uniqueidentifier] NOT NULL,
	[Height] [int] NULL,
	[Width] [int] NULL,
 CONSTRAINT [PK_Picture] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  ForeignKey [FK_MapObjects_Users]    Script Date: 02/25/2010 23:17:56 ******/
ALTER TABLE [dbo].[Media]  WITH CHECK ADD  CONSTRAINT [FK_MapObjects_Users] FOREIGN KEY([User_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Media] CHECK CONSTRAINT [FK_MapObjects_Users]
GO
/****** Object:  ForeignKey [FK_GroupUser_Group]    Script Date: 02/25/2010 23:17:56 ******/
ALTER TABLE [dbo].[GroupUser]  WITH NOCHECK ADD  CONSTRAINT [FK_GroupUser_Group] FOREIGN KEY([Groups_Id])
REFERENCES [dbo].[Groups] ([Id])
GO
ALTER TABLE [dbo].[GroupUser] CHECK CONSTRAINT [FK_GroupUser_Group]
GO
/****** Object:  ForeignKey [FK_GroupUser_User]    Script Date: 02/25/2010 23:17:56 ******/
ALTER TABLE [dbo].[GroupUser]  WITH NOCHECK ADD  CONSTRAINT [FK_GroupUser_User] FOREIGN KEY([Users_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[GroupUser] CHECK CONSTRAINT [FK_GroupUser_User]
GO
/****** Object:  ForeignKey [FK_Videos_Media]    Script Date: 02/25/2010 23:17:56 ******/
ALTER TABLE [dbo].[Videos]  WITH CHECK ADD  CONSTRAINT [FK_Videos_Media] FOREIGN KEY([Id])
REFERENCES [dbo].[Media] ([Id])
GO
ALTER TABLE [dbo].[Videos] CHECK CONSTRAINT [FK_Videos_Media]
GO
/****** Object:  ForeignKey [FK_Comments_MapObjects]    Script Date: 02/25/2010 23:17:56 ******/
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_MapObjects] FOREIGN KEY([MapObject_Id])
REFERENCES [dbo].[Media] ([Id])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_MapObjects]
GO
/****** Object:  ForeignKey [FK_Comments_Users]    Script Date: 02/25/2010 23:17:56 ******/
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Users] FOREIGN KEY([User_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Users]
GO
/****** Object:  ForeignKey [FK_TaggedObjectTag]    Script Date: 02/25/2010 23:17:56 ******/
ALTER TABLE [dbo].[Tags]  WITH NOCHECK ADD  CONSTRAINT [FK_TaggedObjectTag] FOREIGN KEY([MapObject_Id])
REFERENCES [dbo].[Media] ([Id])
GO
ALTER TABLE [dbo].[Tags] CHECK CONSTRAINT [FK_TaggedObjectTag]
GO
/****** Object:  ForeignKey [FK_Picture_Picture]    Script Date: 02/25/2010 23:17:56 ******/
ALTER TABLE [dbo].[Pictures]  WITH CHECK ADD  CONSTRAINT [FK_Picture_Picture] FOREIGN KEY([Id])
REFERENCES [dbo].[Media] ([Id])
GO
ALTER TABLE [dbo].[Pictures] CHECK CONSTRAINT [FK_Picture_Picture]
GO

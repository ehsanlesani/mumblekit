USE [Timerou]
GO
/****** Object:  Table [dbo].[Groups]    Script Date: 04/01/2010 14:23:20 ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 04/01/2010 14:23:20 ******/
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
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Address], [Email], [Password], [Lat], [Lng], [Culture]) VALUES (N'c23aafe7-d94a-4b94-8684-8b04c9333b0e', N'bruno', N'fortunato', NULL, N'davil@email.it', N'ciccio', NULL, NULL, N'en-US')
/****** Object:  Table [dbo].[Media]    Script Date: 04/01/2010 14:23:20 ******/
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
	[FormattedAddress] [nvarchar](max) NULL,
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
INSERT [dbo].[Media] ([Id], [Views], [Created], [Lat], [Lng], [Year], [Country], [CountryCode], [PostalCode], [City], [Region], [Address], [Province], [FormattedAddress], [Title], [Body], [IsTemp], [User_Id]) VALUES (N'bdd4681a-a005-4ce6-81ea-0091beb264dc', 0, CAST(0x00009D270161B73C AS DateTime), 37.520428662591669, 13.617805480957012, 2010, N'Italia', N'IT', N'92025', N'Casteltermini', N'Sicilia', N'92025 Casteltermini AG, Italia', N'AG', NULL, N'92025 Casteltermini AG, Italia', N'<p>Il <strong>primo test</strong> effettuato consiste in una richiesta di <strong>echo</strong>, ossia nell''invio di un messaggio avente come destinatario lo stesso host e la stessa porta; se il messaggio non viene ricevuto, si &egrave; in presenza di un blocco completo del traffico UDP, per cui non &egrave; possibile utilizzare lo <a class="bbcode_url" href="http://www.programmazione.it/index.php?entity=eitem&amp;idItem=43916" target="_self">STUN</a>. Se il messaggio &egrave; stato ricevuto, viene confrontato l''indirizzo IP di origine e di destinazione: se i due indirizzi coincidono, non si &egrave; in presenza di una <a class="bbcode_url" href="http://www.programmazione.it/index.php?entity=eitem&amp;idItem=43461" target="_self">NAT</a>. In entrambi i casi si procede a effettuare il...&nbsp;<font color="#666666">(continua)</font></p>', 0, N'c23aafe7-d94a-4b94-8684-8b04c9333b0e')
INSERT [dbo].[Media] ([Id], [Views], [Created], [Lat], [Lng], [Year], [Country], [CountryCode], [PostalCode], [City], [Region], [Address], [Province], [FormattedAddress], [Title], [Body], [IsTemp], [User_Id]) VALUES (N'eccc98b8-6e79-4424-bd22-091f369e32d5', 0, CAST(0x00009D27016220FF AS DateTime), 37.6249192307612, 21.967414855957, 1998, N'Ελλάς', N'GR', N'', N'Ηραία', N'Πελοπόννησος', N'Ψάριον, Ηραία 22028, Ελλάς', N'Αρκαδία', NULL, N'Ψάριον, Ηραία 22028, Ελλάς', N'', 0, N'c23aafe7-d94a-4b94-8684-8b04c9333b0e')
INSERT [dbo].[Media] ([Id], [Views], [Created], [Lat], [Lng], [Year], [Country], [CountryCode], [PostalCode], [City], [Region], [Address], [Province], [FormattedAddress], [Title], [Body], [IsTemp], [User_Id]) VALUES (N'87a8cecd-c75a-4bf5-a3de-29fb62372f9e', 0, CAST(0x00009D270161E35C AS DateTime), 42.43341622553919, 14.123176574707012, 2010, N'Italia', N'IT', N'65010', N'Spoltore', N'Abruzzo', N'Via Torretta, 65010 Spoltore PE, Italia', N'PE', NULL, N'Via Torretta, 65010 Spoltore PE, Italia', N'<div class="boxtext"><a class="bbcode_url" href="http://en.wikipedia.org/wiki/Actionscript" target="_blank">ActionScript</a> &egrave; il linguaggio Adobe utilizzato per realizzare applicazioni dinamiche, siti web e filmati con animazioni in Flash; &egrave; un linguaggio basato su <a class="bbcode_url" href="http://en.wikipedia.org/wiki/ECMAScript"> ECMAScript</a>, che dalla versione 7 di Flash (MX 2004) presenta elementi della programmazione orientata agli oggetti.  <a class="bbcode_url" href="http://en.wikipedia.org/wiki/Actionscript" target="_blank">ActionScript</a> &egrave; sempre stato associato all&rsquo;utilizzo congiunto dei tool di sviluppo di Adobe, in quanto se compilato sotto forma di file SWF, poteva essere inizialmente prodotto solo tramite il compilatore MMC (Macromedia...&nbsp;<font color="#666666">(continua)</font></div>', 0, N'c23aafe7-d94a-4b94-8684-8b04c9333b0e')
INSERT [dbo].[Media] ([Id], [Views], [Created], [Lat], [Lng], [Year], [Country], [CountryCode], [PostalCode], [City], [Region], [Address], [Province], [FormattedAddress], [Title], [Body], [IsTemp], [User_Id]) VALUES (N'225fdcbb-3785-4144-b71d-3335f7bf4870', 0, CAST(0x00009D270162E7A0 AS DateTime), 41.4198950203632, 21.703742980957, 1894, N'Macedonia', N'MK', N'', N'', N'', N'Macedonia', N'', NULL, N'Macedonia', N'<div class="contributor">Scritto da <a href="http://www.programmazione.it/index.php?entity=esearch&amp;arc=0&amp;dir=za&amp;ord=0&amp;rfp=10&amp;idx=12&amp;idPage=1&amp;k=%22Alessandro+Rusani%22" target="_self">Alessandro Rusani</a> il 24-02-2010 ore 11:05</div>
<div class="boxtext"><a class="bbcode_url" href="http://en.wikipedia.org/wiki/Actionscript" target="_blank">ActionScript</a> &egrave; il linguaggio Adobe utilizzato per realizzare applicazioni dinamiche, siti web e filmati con animazioni in Flash; &egrave; un linguaggio basato su <a class="bbcode_url" href="http://en.wikipedia.org/wiki/ECMAScript"> ECMAScript</a>, che dalla versione 7 di Flash (MX 2004) presenta elementi della programmazione orientata agli oggetti.  <a class="bbcode_url" href="http://en.wikipedia.org/wiki/Actionscript" target="_blank">ActionScript</a> &egrave; sempre stato associato all&rsquo;utilizzo congiunto dei tool di sviluppo di Adobe, in quanto se compilato sotto forma di file SWF, poteva essere inizialmente prodotto solo tramite il compilatore MMC (Macromedia...&nbsp;<span style="color: #666666;">(continua)</span></div>', 0, N'c23aafe7-d94a-4b94-8684-8b04c9333b0e')
INSERT [dbo].[Media] ([Id], [Views], [Created], [Lat], [Lng], [Year], [Country], [CountryCode], [PostalCode], [City], [Region], [Address], [Province], [FormattedAddress], [Title], [Body], [IsTemp], [User_Id]) VALUES (N'63688fe0-ec77-4cbb-8f88-42349ec0640b', 0, CAST(0x00009D26014A5DE1 AS DateTime), 40.624194618726058, 16.254524230957013, 2010, N'Italia', N'IT', N'', N'Grassano', N'Basilicata', N'Grassano MT, Italia', N'MT', NULL, N'Grassano MT, Italia', N'', 0, N'c23aafe7-d94a-4b94-8684-8b04c9333b0e')
INSERT [dbo].[Media] ([Id], [Views], [Created], [Lat], [Lng], [Year], [Country], [CountryCode], [PostalCode], [City], [Region], [Address], [Province], [FormattedAddress], [Title], [Body], [IsTemp], [User_Id]) VALUES (N'2ab2f4b4-2936-4082-8b77-543bd62a8962', 0, CAST(0x00009D270162F09A AS DateTime), 43.653789393951, 18.803352355957, 2010, N'Bosnia and Herzegovina', N'BA', N'', N'', N'', N'Bosnia and Herzegovina', N'', NULL, N'Bosnia and Herzegovina', N'', 0, N'c23aafe7-d94a-4b94-8684-8b04c9333b0e')
INSERT [dbo].[Media] ([Id], [Views], [Created], [Lat], [Lng], [Year], [Country], [CountryCode], [PostalCode], [City], [Region], [Address], [Province], [FormattedAddress], [Title], [Body], [IsTemp], [User_Id]) VALUES (N'f1024678-e155-4ef4-8415-71743ae5b1f7', 0, CAST(0x00009D2701617826 AS DateTime), 43.653789393951008, 17.397102355957013, 2010, N'Bosnia and Herzegovina', N'BA', N'', N'', N'', N'Bosnia and Herzegovina', N'', NULL, N'Bosnia and Herzegovina', N'', 0, N'c23aafe7-d94a-4b94-8684-8b04c9333b0e')
INSERT [dbo].[Media] ([Id], [Views], [Created], [Lat], [Lng], [Year], [Country], [CountryCode], [PostalCode], [City], [Region], [Address], [Province], [FormattedAddress], [Title], [Body], [IsTemp], [User_Id]) VALUES (N'87bef2ca-2f65-4a7d-a1f7-739a85c610a5', 0, CAST(0x00009D27016215EC AS DateTime), 43.812556417674465, 6.3228836059570126, 2010, N'France', N'FR', N'', N'La Palud-sur-Verdon', N'Provence-Alpes-Côte d''Azur', N'04120 La Palud-sur-Verdon, France', N'Alpes-de-Haute-Provence', NULL, N'04120 La Palud-sur-Verdon, France', N'<div class="contributor">Scritto da <a href="http://www.programmazione.it/index.php?entity=esearch&amp;arc=0&amp;dir=za&amp;ord=0&amp;rfp=10&amp;idx=12&amp;idPage=1&amp;k=%22Alessandro+Rusani%22" target="_self">Alessandro Rusani</a> il 24-02-2010 ore 11:05</div>
<div class="boxtext"><a class="bbcode_url" href="http://en.wikipedia.org/wiki/Actionscript" target="_blank">ActionScript</a> &egrave; il linguaggio Adobe utilizzato per realizzare applicazioni dinamiche, siti web e filmati con animazioni in Flash; &egrave; un linguaggio basato su <a class="bbcode_url" href="http://en.wikipedia.org/wiki/ECMAScript"> ECMAScript</a>, che dalla versione 7 di Flash (MX 2004) presenta elementi della programmazione orientata agli oggetti.  <a class="bbcode_url" href="http://en.wikipedia.org/wiki/Actionscript" target="_blank">ActionScript</a> &egrave; sempre stato associato all&rsquo;utilizzo congiunto dei tool di sviluppo di Adobe, in quanto se compilato sotto forma di file SWF, poteva essere inizialmente prodotto solo tramite il compilatore MMC (Macromedia...&nbsp;<font color="#666666">(continua)</font></div>', 0, N'c23aafe7-d94a-4b94-8684-8b04c9333b0e')
INSERT [dbo].[Media] ([Id], [Views], [Created], [Lat], [Lng], [Year], [Country], [CountryCode], [PostalCode], [City], [Region], [Address], [Province], [FormattedAddress], [Title], [Body], [IsTemp], [User_Id]) VALUES (N'336df3d2-0ae3-4c7b-80c8-7c62a8bbacda', 0, CAST(0x00009D2A01311D8E AS DateTime), 41.8954656, 12.4823243, 2010, N'Italia', N'IT', N'', N'Roma', N'Lazio', N'Roma, Italia', N'RM', NULL, N'Roma, Italia', N'<p>Altra immagine di uovo!</p>', 0, N'c23aafe7-d94a-4b94-8684-8b04c9333b0e')
INSERT [dbo].[Media] ([Id], [Views], [Created], [Lat], [Lng], [Year], [Country], [CountryCode], [PostalCode], [City], [Region], [Address], [Province], [FormattedAddress], [Title], [Body], [IsTemp], [User_Id]) VALUES (N'5818149e-4c3f-4b70-9c1b-ab65fd69ea16', 0, CAST(0x00009D2E0189686A AS DateTime), 42.5468336740235, 13.002571105957, 2010, N'Italia', N'IT', N'', N'Leonessa', N'Lazio', N'Leonessa RI, Italia', N'RI', NULL, N'Leonessa RI, Italia', N'', 0, N'c23aafe7-d94a-4b94-8684-8b04c9333b0e')
INSERT [dbo].[Media] ([Id], [Views], [Created], [Lat], [Lng], [Year], [Country], [CountryCode], [PostalCode], [City], [Region], [Address], [Province], [FormattedAddress], [Title], [Body], [IsTemp], [User_Id]) VALUES (N'36bcd595-eb8a-4ba5-bc4f-da87e1859306', 0, CAST(0x00009D2701622CDD AS DateTime), 42.1408273715342, 8.82776641845701, 1999, N'France', N'FR', N'', N'Murzo', N'Corse', N'20160 Murzo, France', N'2A', NULL, N'20160 Murzo, France', N'<div class="contributor">Scritto da <a href="http://www.programmazione.it/index.php?entity=esearch&amp;arc=0&amp;dir=za&amp;ord=0&amp;rfp=10&amp;idx=12&amp;idPage=1&amp;k=%22Alessandro+Rusani%22" target="_self">Alessandro Rusani</a> il 24-02-2010 ore 11:05</div>
<div class="boxtext"><a class="bbcode_url" href="http://en.wikipedia.org/wiki/Actionscript" target="_blank">ActionScript</a> &egrave; il linguaggio Adobe utilizzato per realizzare applicazioni dinamiche, siti web e filmati con animazioni in Flash; &egrave; un linguaggio basato su <a class="bbcode_url" href="http://en.wikipedia.org/wiki/ECMAScript"> ECMAScript</a>, che dalla versione 7 di Flash (MX 2004) presenta elementi della programmazione orientata agli oggetti.  <a class="bbcode_url" href="http://en.wikipedia.org/wiki/Actionscript" target="_blank">ActionScript</a> &egrave; sempre stato associato all&rsquo;utilizzo congiunto dei tool di sviluppo di Adobe, in quanto se compilato sotto forma di file SWF, poteva essere inizialmente prodotto solo tramite il compilatore MMC (Macromedia...&nbsp;<span style="color: #666666;">(continua)</span></div>', 0, N'c23aafe7-d94a-4b94-8684-8b04c9333b0e')
INSERT [dbo].[Media] ([Id], [Views], [Created], [Lat], [Lng], [Year], [Country], [CountryCode], [PostalCode], [City], [Region], [Address], [Province], [FormattedAddress], [Title], [Body], [IsTemp], [User_Id]) VALUES (N'd0336fe3-ccd6-4f5c-855a-f4892f36f858', 0, CAST(0x00009D2701620279 AS DateTime), 44.84985764359417, 9.9703445434570117, 2010, N'Italia', N'IT', N'29010', N'Alseno', N'Emilia Romagna', N'SP31, 29010 Alseno PC, Italia', N'PC', NULL, N'SP31, 29010 Alseno PC, Italia', N'<div class="contributor">Scritto da <a href="http://www.programmazione.it/index.php?entity=esearch&amp;arc=0&amp;dir=za&amp;ord=0&amp;rfp=10&amp;idx=12&amp;idPage=1&amp;k=%22Alessandro+Rusani%22" target="_self">Alessandro Rusani</a> il 24-02-2010 ore 11:05</div>
<div class="boxtext"><a class="bbcode_url" href="http://en.wikipedia.org/wiki/Actionscript" target="_blank">ActionScript</a> &egrave; il linguaggio Adobe utilizzato per realizzare applicazioni dinamiche, siti web e filmati con animazioni in Flash; &egrave; un linguaggio basato su <a class="bbcode_url" href="http://en.wikipedia.org/wiki/ECMAScript"> ECMAScript</a>, che dalla versione 7 di Flash (MX 2004) presenta elementi della programmazione orientata agli oggetti.  <a class="bbcode_url" href="http://en.wikipedia.org/wiki/Actionscript" target="_blank">ActionScript</a> &egrave; sempre stato associato all&rsquo;utilizzo congiunto dei tool di sviluppo di Adobe, in quanto se compilato sotto forma di file SWF, poteva essere inizialmente prodotto solo tramite il compilatore MMC (Macromedia...&nbsp;<font color="#666666">(continua)</font></div>', 0, N'c23aafe7-d94a-4b94-8684-8b04c9333b0e')
INSERT [dbo].[Media] ([Id], [Views], [Created], [Lat], [Lng], [Year], [Country], [CountryCode], [PostalCode], [City], [Region], [Address], [Province], [FormattedAddress], [Title], [Body], [IsTemp], [User_Id]) VALUES (N'96f40e38-092b-4115-8c46-fd616510ad98', 0, CAST(0x00009D270004E0B0 AS DateTime), 43.8759453644202, 16.693977355957, 2010, N'Bosnia and Herzegovina', N'BA', N'', N'', N'', N'Bosnia and Herzegovina', N'', NULL, N'Bosnia and Herzegovina aaa aaa', N'<p>Ciao da me.</p>
<p>Sei in bosnia ed e tutto bello</p>', 0, N'c23aafe7-d94a-4b94-8684-8b04c9333b0e')
/****** Object:  Table [dbo].[GroupUser]    Script Date: 04/01/2010 14:23:20 ******/
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
/****** Object:  Table [dbo].[Videos]    Script Date: 04/01/2010 14:23:20 ******/
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
/****** Object:  Table [dbo].[Comments]    Script Date: 04/01/2010 14:23:20 ******/
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
/****** Object:  Table [dbo].[Tags]    Script Date: 04/01/2010 14:23:20 ******/
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
/****** Object:  Table [dbo].[Pictures]    Script Date: 04/01/2010 14:23:20 ******/
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
INSERT [dbo].[Pictures] ([Id], [Height], [Width]) VALUES (N'bdd4681a-a005-4ce6-81ea-0091beb264dc', 480, 640)
INSERT [dbo].[Pictures] ([Id], [Height], [Width]) VALUES (N'eccc98b8-6e79-4424-bd22-091f369e32d5', 400, 640)
INSERT [dbo].[Pictures] ([Id], [Height], [Width]) VALUES (N'87a8cecd-c75a-4bf5-a3de-29fb62372f9e', 480, 640)
INSERT [dbo].[Pictures] ([Id], [Height], [Width]) VALUES (N'225fdcbb-3785-4144-b71d-3335f7bf4870', 400, 640)
INSERT [dbo].[Pictures] ([Id], [Height], [Width]) VALUES (N'63688fe0-ec77-4cbb-8f88-42349ec0640b', 480, 640)
INSERT [dbo].[Pictures] ([Id], [Height], [Width]) VALUES (N'2ab2f4b4-2936-4082-8b77-543bd62a8962', 400, 640)
INSERT [dbo].[Pictures] ([Id], [Height], [Width]) VALUES (N'f1024678-e155-4ef4-8415-71743ae5b1f7', 480, 640)
INSERT [dbo].[Pictures] ([Id], [Height], [Width]) VALUES (N'87bef2ca-2f65-4a7d-a1f7-739a85c610a5', 400, 640)
INSERT [dbo].[Pictures] ([Id], [Height], [Width]) VALUES (N'336df3d2-0ae3-4c7b-80c8-7c62a8bbacda', 491, 640)
INSERT [dbo].[Pictures] ([Id], [Height], [Width]) VALUES (N'5818149e-4c3f-4b70-9c1b-ab65fd69ea16', 479, 318)
INSERT [dbo].[Pictures] ([Id], [Height], [Width]) VALUES (N'36bcd595-eb8a-4ba5-bc4f-da87e1859306', 400, 640)
INSERT [dbo].[Pictures] ([Id], [Height], [Width]) VALUES (N'd0336fe3-ccd6-4f5c-855a-f4892f36f858', 480, 640)
INSERT [dbo].[Pictures] ([Id], [Height], [Width]) VALUES (N'96f40e38-092b-4115-8c46-fd616510ad98', 480, 640)
/****** Object:  ForeignKey [FK_MapObjects_Users]    Script Date: 04/01/2010 14:23:20 ******/
ALTER TABLE [dbo].[Media]  WITH CHECK ADD  CONSTRAINT [FK_MapObjects_Users] FOREIGN KEY([User_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Media] CHECK CONSTRAINT [FK_MapObjects_Users]
GO
/****** Object:  ForeignKey [FK_GroupUser_Group]    Script Date: 04/01/2010 14:23:20 ******/
ALTER TABLE [dbo].[GroupUser]  WITH NOCHECK ADD  CONSTRAINT [FK_GroupUser_Group] FOREIGN KEY([Groups_Id])
REFERENCES [dbo].[Groups] ([Id])
GO
ALTER TABLE [dbo].[GroupUser] CHECK CONSTRAINT [FK_GroupUser_Group]
GO
/****** Object:  ForeignKey [FK_GroupUser_User]    Script Date: 04/01/2010 14:23:20 ******/
ALTER TABLE [dbo].[GroupUser]  WITH NOCHECK ADD  CONSTRAINT [FK_GroupUser_User] FOREIGN KEY([Users_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[GroupUser] CHECK CONSTRAINT [FK_GroupUser_User]
GO
/****** Object:  ForeignKey [FK_Videos_Media]    Script Date: 04/01/2010 14:23:20 ******/
ALTER TABLE [dbo].[Videos]  WITH CHECK ADD  CONSTRAINT [FK_Videos_Media] FOREIGN KEY([Id])
REFERENCES [dbo].[Media] ([Id])
GO
ALTER TABLE [dbo].[Videos] CHECK CONSTRAINT [FK_Videos_Media]
GO
/****** Object:  ForeignKey [FK_Comments_MapObjects]    Script Date: 04/01/2010 14:23:20 ******/
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_MapObjects] FOREIGN KEY([MapObject_Id])
REFERENCES [dbo].[Media] ([Id])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_MapObjects]
GO
/****** Object:  ForeignKey [FK_Comments_Users]    Script Date: 04/01/2010 14:23:20 ******/
ALTER TABLE [dbo].[Comments]  WITH CHECK ADD  CONSTRAINT [FK_Comments_Users] FOREIGN KEY([User_Id])
REFERENCES [dbo].[Users] ([Id])
GO
ALTER TABLE [dbo].[Comments] CHECK CONSTRAINT [FK_Comments_Users]
GO
/****** Object:  ForeignKey [FK_TaggedObjectTag]    Script Date: 04/01/2010 14:23:20 ******/
ALTER TABLE [dbo].[Tags]  WITH NOCHECK ADD  CONSTRAINT [FK_TaggedObjectTag] FOREIGN KEY([MapObject_Id])
REFERENCES [dbo].[Media] ([Id])
GO
ALTER TABLE [dbo].[Tags] CHECK CONSTRAINT [FK_TaggedObjectTag]
GO
/****** Object:  ForeignKey [FK_Picture_Picture]    Script Date: 04/01/2010 14:23:20 ******/
ALTER TABLE [dbo].[Pictures]  WITH CHECK ADD  CONSTRAINT [FK_Picture_Picture] FOREIGN KEY([Id])
REFERENCES [dbo].[Media] ([Id])
GO
ALTER TABLE [dbo].[Pictures] CHECK CONSTRAINT [FK_Picture_Picture]
GO

USE [master]
GO
CREATE DATABASE [GameHub]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GameHub', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\GameHub.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'GameHub_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\GameHub_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [GameHub] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GameHub].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GameHub] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GameHub] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GameHub] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GameHub] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GameHub] SET ARITHABORT OFF 
GO
ALTER DATABASE [GameHub] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GameHub] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GameHub] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GameHub] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GameHub] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GameHub] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GameHub] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GameHub] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GameHub] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GameHub] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GameHub] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GameHub] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GameHub] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GameHub] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GameHub] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GameHub] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GameHub] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GameHub] SET RECOVERY FULL 
GO
ALTER DATABASE [GameHub] SET  MULTI_USER 
GO
ALTER DATABASE [GameHub] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GameHub] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GameHub] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GameHub] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [GameHub] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'GameHub', N'ON'
GO
USE [GameHub]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[admin_Employee](
	[EmpID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [varchar](20) NOT NULL,
	[LastName] [varchar](20) NULL,
	[Age] [int] NULL,
	[DateofBirth] [date] NULL,
	[Gender] [varchar](10) NULL,
	[Email] [varchar](50) NULL,
	[Address] [varchar](50) NULL,
	[Phone] [varchar](15) NOT NULL,
	[Mobile] [varchar](15) NOT NULL,
	[PhotoPath] [varchar](500) NULL,
 CONSTRAINT [PK_admin_Employee] PRIMARY KEY CLUSTERED 
(
	[EmpID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[admin_Login](
	[LoginID] [int] IDENTITY(1,1) NOT NULL,
	[EmpID] [int] NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[RoleType] [int] NULL,
	[Notes] [varchar](255) NULL,
 CONSTRAINT [PK_admin_Login] PRIMARY KEY CLUSTERED 
(
	[LoginID] ASC,
	[UserName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Categories](
	[CategoryID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](20) NOT NULL,
	[Description] [varchar](50) NULL,
	[Picture1] [varchar](255) NULL,
	[Picture2] [varchar](250) NULL,
	[isActive] [bit] NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[CategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customers](
	[CustomerID] [int] IDENTITY(1,1) NOT NULL,
	[First Name] [varchar](50) NOT NULL,
	[Last Name] [varchar](50) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Age] [int] NULL,
	[Gender] [varchar](50) NULL,
	[DateofBirth] [date] NULL,
	[Organization] [varchar](50) NULL,
	[Country] [varchar](50) NULL,
	[State] [varchar](50) NULL,
	[City] [varchar](50) NULL,
	[PostalCode] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[AltEmail] [varchar](50) NULL,
	[Phone1] [varchar](50) NULL,
	[Phone2] [varchar](20) NULL,
	[Mobile1] [varchar](50) NULL,
	[Mobile2] [varchar](50) NULL,
	[Address1] [varchar](50) NULL,
	[Address2] [varchar](50) NULL,
	[Picture] [varchar](250) NULL,
	[status] [varchar](50) NULL,
	[LastLogin] [datetime] NULL,
	[Created] [date] NULL,
	[Notes] [varchar](250) NULL,
 CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[genMainSlider](
	[MainSliderID] [int] IDENTITY(1,1) NOT NULL,
	[ImageURL] [varchar](500) NULL,
	[AltText] [varchar](255) NULL,
	[OfferTag] [varchar](50) NULL,
	[Title] [varchar](50) NULL,
	[Description] [varchar](255) NULL,
	[BtnText] [varchar](50) NULL,
	[isDeleted] [bit] NULL,
 CONSTRAINT [PK_genMainSlider] PRIMARY KEY CLUSTERED 
(
	[MainSliderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[genPromoRight](
	[PromoRightID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[ImageURL] [varchar](500) NULL,
	[AltText] [varchar](500) NULL,
	[OfferTag] [varchar](50) NULL,
	[Title] [varchar](50) NULL,
	[isDeleted] [bit] NULL,
 CONSTRAINT [PK_genPromoRight] PRIMARY KEY CLUSTERED 
(
	[PromoRightID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Order](
	[OrderID] [int] NOT NULL,
	[CustomerID] [int] NOT NULL,
	[PaymentID] [int] NULL,
	[ShippingID] [int] NULL,
	[Discount] [int] NULL CONSTRAINT [DF_Order_Discount]  DEFAULT ((0)),
	[Taxes] [int] NULL CONSTRAINT [DF_Order_Taxes]  DEFAULT ((0)),
	[TotalAmount] [int] NULL,
	[isCompleted] [bit] NULL CONSTRAINT [DF_Order_isCompleted]  DEFAULT ((0)),
	[OrderDate] [datetime] NULL,
	[DIspatched] [bit] NULL CONSTRAINT [DF_Order_DIspatched]  DEFAULT ((0)),
	[DispatchedDate] [datetime] NULL,
	[Shipped] [bit] NULL CONSTRAINT [DF_Order_Shipped]  DEFAULT ((0)),
	[ShippingDate] [datetime] NULL,
	[Deliver] [bit] NULL CONSTRAINT [DF_Order_Deliver]  DEFAULT ((0)),
	[DeliveryDate] [datetime] NULL,
	[Notes] [varchar](500) NULL,
	[CancelOrder] [bit] NULL CONSTRAINT [DF_Order_CancelOrder]  DEFAULT ((0)),
 CONSTRAINT [PK_Oder] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderDetailsID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[UnitPrice] [decimal](18, 0) NULL,
	[Quantity] [int] NULL,
	[Discount] [decimal](18, 0) NULL,
	[TotalAmount] [decimal](18, 0) NULL,
	[OrderDate] [datetime] NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[OrderDetailsID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[PaymentID] [int] NOT NULL,
	[Type] [int] NOT NULL,
	[CreditAmount] [money] NULL,
	[DebitAmount] [money] NULL,
	[Balance] [money] NULL,
	[PaymentDateTime] [datetime] NULL,
 CONSTRAINT [PK_Payment] PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[PaymentType](
	[PayTypeID] [int] IDENTITY(1,1) NOT NULL,
	[TypeName] [varchar](50) NOT NULL,
	[Description] [varchar](500) NULL,
 CONSTRAINT [PK_PaymentType] PRIMARY KEY CLUSTERED 
(
	[PayTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[SupplierID] [int] NOT NULL,
	[CategoryID] [int] NOT NULL,
	[SubCategoryID] [int] NULL,
	[QuantityPerUnit] [varchar](50) NULL,
	[UnitPrice] [decimal](18, 0) NOT NULL,
	[OldPrice] [decimal](18, 0) NULL,
	[UnitWeight] [varchar](50) NULL,
	[Size] [varchar](50) NULL,
	[Discount] [decimal](18, 0) NULL,
	[UnitInStock] [int] NULL,
	[UnitOnOrder] [int] NULL,
	[ProductAvailable] [bit] NULL,
	[ImageURL] [varchar](500) NULL,
	[AltText] [varchar](50) NULL,
	[AddBadge] [bit] NULL,
	[OfferTitle] [varchar](50) NULL,
	[OfferBadgeClass] [varchar](50) NULL,
	[ShortDescription] [varchar](300) NULL,
	[LongDescription] [varchar](2000) NULL,
	[Picture1] [varchar](500) NULL,
	[Picture2] [varchar](500) NULL,
	[Picture3] [varchar](500) NULL,
	[Picture4] [varchar](500) NULL,
	[Note] [varchar](250) NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[RecentlyViews](
	[RViewID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[ViewDate] [datetime] NOT NULL,
	[Note] [varchar](255) NULL,
 CONSTRAINT [PK_RecentlyViews] PRIMARY KEY CLUSTERED 
(
	[RViewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Review](
	[ReviewID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NULL,
	[ProductID] [int] NULL,
	[Name] [varchar](50) NULL,
	[Email] [varchar](50) NULL,
	[Review] [varchar](500) NULL,
	[Rate] [int] NULL,
	[DateTime] [datetime] NULL,
	[isDelete] [bit] NULL,
 CONSTRAINT [PK_Review] PRIMARY KEY CLUSTERED 
(
	[ReviewID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NOT NULL,
	[Description] [varchar](500) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ShippingDetails](
	[ShippingID] [int] NOT NULL,
	[FirstName] [varchar](20) NOT NULL,
	[LastName] [varchar](20) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Mobile] [varchar](20) NOT NULL,
	[Address] [varchar](100) NOT NULL,
	[Province] [varchar](20) NULL,
	[City] [varchar](20) NULL,
	[PostCode] [varchar](10) NULL,
 CONSTRAINT [PK_ShippingDetails] PRIMARY KEY CLUSTERED 
(
	[ShippingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SubCategory](
	[SubCategoryID] [int] IDENTITY(1,1) NOT NULL,
	[CategoryID] [int] NOT NULL,
	[Name] [nchar](20) NOT NULL,
	[Description] [varchar](250) NULL,
	[Picture1] [varchar](500) NULL,
	[Picture2] [varchar](500) NULL,
	[isActive] [bit] NULL,
 CONSTRAINT [PK_SubCategory] PRIMARY KEY CLUSTERED 
(
	[SubCategoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Suppliers](
	[SupplierID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyName] [varchar](50) NOT NULL,
	[ContactName] [varchar](50) NULL,
	[ContactTitle] [varchar](50) NULL,
	[Address] [varchar](128) NULL,
	[Mobile] [varchar](15) NULL,
	[Phone] [varchar](15) NOT NULL,
	[Fax] [varchar](20) NULL,
	[Email] [varchar](50) NOT NULL,
	[City] [varchar](20) NULL,
	[Country] [varchar](20) NULL,
 CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED 
(
	[SupplierID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Wishlist](
	[WishlistID] [int] IDENTITY(1,1) NOT NULL,
	[CustomerID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[isActive] [bit] NULL CONSTRAINT [DF_Wishlist_isActive]  DEFAULT ((1)),
 CONSTRAINT [PK_Wishlist] PRIMARY KEY CLUSTERED 
(
	[WishlistID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[admin_Employee] ON 
INSERT [dbo].[admin_Employee] ([EmpID], [FirstName], [LastName], [Age], [DateofBirth], [Gender], [Email], [Address], [Phone], [Mobile], [PhotoPath]) VALUES (1, N'Ramazan', N'Mustafazade', 22, CAST(N'2005-07-07' AS Date), N'Male', N'Admin', N'Baku', N'admin',905519338481, NULL)
SET IDENTITY_INSERT [dbo].[admin_Employee] OFF
SET IDENTITY_INSERT [dbo].[admin_Login] ON 

INSERT [dbo].[admin_Login] ([LoginID], [EmpID], [UserName], [Password], [RoleType], [Notes]) VALUES (1, 1, N'admin', N'admin', 2, NULL)
SET IDENTITY_INSERT [dbo].[admin_Login] OFF
SET IDENTITY_INSERT [dbo].[Categories] ON 

INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (1, N'Fps Games', NULL, NULL, NULL, NULL)
INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (2, N'Game Projects', NULL, NULL, NULL, NULL)
INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (3, N'Sport Games', NULL, NULL, NULL, NULL)
INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (4, N'Strategy Games', NULL, NULL, NULL, NULL)
INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (5, N'Action Adventure', NULL, NULL, NULL, NULL)
INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (6, N'Survival Games', NULL, NULL, NULL, NULL)

--INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (7, N'Cs:Go', NULL, NULL, NULL, NULL)
--INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (8, N'Pubg Mobile', NULL, NULL, NULL, NULL)
--INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (9, N'Call Of Duty Mobile', NULL, NULL, NULL, NULL)
--INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (10, N'Call Of Duty Warzone', NULL, NULL, NULL, NULL)
--INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (11, N'Critical Ops', NULL, NULL, NULL, NULL)
--INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (12, N'Football Players', NULL, NULL, NULL, NULL)
--INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (13, N'Black Force', NULL, NULL, NULL, NULL)
--INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (14, N'Drone Simulator', NULL, NULL, NULL, NULL)
--INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (15, N'Car Ar Foundation', NULL, NULL, NULL, NULL)
--INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (16, N'Race King', NULL, NULL, NULL, NULL)
--INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (17, N'Earn Promo Code', NULL, NULL, NULL, NULL)
--INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (18, N'Fifa', NULL, NULL, NULL, NULL)
--INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (19, N'Mobile Legends', NULL, NULL, NULL, NULL)
--INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (20, N'Assasins Creed', NULL, NULL, NULL, NULL)
--INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (21, N'Clash Royale', NULL, NULL, NULL, NULL)
--INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (22, N'Hay Day', NULL, NULL, NULL, NULL)
--INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (23, N'Clash Of Clans', NULL, NULL, NULL, NULL)
--INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (24, N'Fortnite', NULL, NULL, NULL, NULL)
--INSERT [dbo].[Categories] ([CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (25, N'Grand Theft Auto V', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Categories] OFF
SET IDENTITY_INSERT [dbo].[Customers] ON 
INSERT [dbo].[Customers] ([CustomerID], [First Name], [Last Name], [UserName], [Password], [Age], [Gender], [DateofBirth], [Organization], [Country], [State], [City], [PostalCode], [Email], [AltEmail], [Phone1], [Phone2], [Mobile1], [Mobile2], [Address1], [Address2], [Picture], [status], [LastLogin], [Created], [Notes]) VALUES (1, N'Rufet', N'Rasulov', N'rufernweh', N'1234', 20, NULL, NULL, NULL, N'Azerbaijan', NULL, NULL, NULL, N'rufetresulov@gmail.com', NULL, NULL, NULL, 994509873423, NULL, N'Baku', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [First Name], [Last Name], [UserName], [Password], [Age], [Gender], [DateofBirth], [Organization], [Country], [State], [City], [PostalCode], [Email], [AltEmail], [Phone1], [Phone2], [Mobile1], [Mobile2], [Address1], [Address2], [Picture], [status], [LastLogin], [Created], [Notes]) VALUES (2, N'Ferid', N'Agayev', N'faridagayev', N'1234', 19, NULL, NULL, NULL, N'Pakistan', NULL, NULL, NULL, N'feridagayev@gmail.com', NULL, NULL, NULL, 994517654409, NULL, N'Karaci', NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Customers] ([CustomerID], [First Name], [Last Name], [UserName], [Password], [Age], [Gender], [DateofBirth], [Organization], [Country], [State], [City], [PostalCode], [Email], [AltEmail], [Phone1], [Phone2], [Mobile1], [Mobile2], [Address1], [Address2], [Picture], [status], [LastLogin], [Created], [Notes]) VALUES (3, N'Raqif', N'Isgenderov', N'raqif123', N'1234', 17, NULL, NULL, NULL, N'Turkey', NULL, NULL, NULL, N'raqif123@gmail.com', NULL, NULL, NULL, 994774556767, NULL, N'Istanbul', NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Customers] OFF
SET IDENTITY_INSERT [dbo].[genMainSlider] ON 

INSERT [dbo].[genMainSlider] ([MainSliderID], [ImageURL], [AltText], [OfferTag], [Title], [Description], [BtnText], [isDeleted]) VALUES (1, N'/Content/img/slider/bannerone.jpg', N'A New Case', N'Save Up to 75% Off', N'A New Case', N'Today we are excited to ship the Recoil Case, featuring 17 weapon finishes from community artists and including the Broken Fang Case Gloves as rare special items!The Recoil Case is dropping in-game now!', N'SHOP NOW', 0)
INSERT [dbo].[genMainSlider] ([MainSliderID], [ImageURL], [AltText], [OfferTag], [Title], [Description], [BtnText], [isDeleted]) VALUES (2, N'/Content/img/slider/bannertwo3.jpg', N'BLACK OPS III', N'Save Up to 40% Off', N'BLACK OPS III', N'Welcome to 2065. A new breed of Black Ops soldier emerges and the lines are blurred between our own humanity and the cutting-edge military robotics that define the future of combat.', N'SHOP NOW', 0)
INSERT [dbo].[genMainSlider] ([MainSliderID], [ImageURL], [AltText], [OfferTag], [Title], [Description], [BtnText], [isDeleted]) VALUES (3, N'/Content/img/slider/bannerthree.jpg', N'Call of Duty® Warzone', N'Save Up to 75% Off', N'Call of Duty® Warzone', N'Season 02 of Call of Duty®: Warzone™ 2.0 introduces players to Ashika Island, a small-scale Japanese-themed island map. Drop in through the mist and discover a world of castles, underground waterways, quaint residential areas and more.', N'SHOP NOW', 0)
INSERT [dbo].[genMainSlider] ([MainSliderID], [ImageURL], [AltText], [OfferTag], [Title], [Description], [BtnText], [isDeleted]) VALUES (4, N'/Content/img/slider/bannerfour.jpg', N'BATTLE ROYALE', N'Save Up to 75% Off', N'BATTLE ROYALE', N'The battle is building! Drop into the Battle Royale. Loot, build, explore, and fight in a game of 100 players competing to be the last one standing.', N'SHOP NOW', 0)
INSERT [dbo].[genMainSlider] ([MainSliderID], [ImageURL], [AltText], [OfferTag], [Title], [Description], [BtnText], [isDeleted]) VALUES (5, N'/Content/img/slider/bannerfive.jpg', N'Welcome to Steam', N'Save Up to 50% Off', N'Welcome to Steam', N'The Steam Spring Sale is on now — find great deals on thousands of games!', N'SHOP NOW', 0)
INSERT [dbo].[genMainSlider] ([MainSliderID], [ImageURL], [AltText], [OfferTag], [Title], [Description], [BtnText], [isDeleted]) VALUES (6, N'/Content/img/slider/bannersix.jpg', N'Assassins Creed Universe', N'Save Up to 50% Off', N'Assassins Creed Universe', N'Play your way through history in the award-winning video game series. Assassins Creed immerses you in the memories of your ancestors, fighting to protect free will at pivotal moments in human history.', N'SHOP NOW', 0)
SET IDENTITY_INSERT [dbo].[genMainSlider] OFF
SET IDENTITY_INSERT [dbo].[genPromoRight] ON 

INSERT [dbo].[genPromoRight] ([PromoRightID], [CategoryID], [ImageURL], [AltText], [OfferTag], [Title], [isDeleted]) VALUES (0, 2, N'/Content/img/promo-banner-gameprojects.jpg', N'img', N'Exclusive Item', N'Game Projects', 0)
INSERT [dbo].[genPromoRight] ([PromoRightID], [CategoryID], [ImageURL], [AltText], [OfferTag], [Title], [isDeleted]) VALUES (1, 3, N'/Content/img/promo-banner-sport.jpg', N'img', N'Sales off', N'Sport', 0)
INSERT [dbo].[genPromoRight] ([PromoRightID], [CategoryID], [ImageURL], [AltText], [OfferTag], [Title], [isDeleted]) VALUES (2, 5, N'/Content/img/promo-banner-actionadventure.jpg', N'img', N'Most Popular', N'Action Adventure', 0)
INSERT [dbo].[genPromoRight] ([PromoRightID], [CategoryID], [ImageURL], [AltText], [OfferTag], [Title], [isDeleted]) VALUES (3, 6, N'/Content/img/promo-banner-survivalgames.jpg', N'img', N'25% off', N'Survival Games', 0)
SET IDENTITY_INSERT [dbo].[genPromoRight] OFF
INSERT [dbo].[Order] ([OrderID], [CustomerID], [PaymentID], [ShippingID], [Discount], [Taxes], [TotalAmount], [isCompleted], [OrderDate], [DIspatched], [DispatchedDate], [Shipped], [ShippingDate], [Deliver], [DeliveryDate], [Notes], [CancelOrder]) VALUES (1, 1, 1, 1, 0, 0, 20, 1, CAST(N'2023-09-09 20:54:32.980' AS DateTime), 0, NULL, 0, NULL, 0, NULL, NULL, 0)
INSERT [dbo].[Order] ([OrderID], [CustomerID], [PaymentID], [ShippingID], [Discount], [Taxes], [TotalAmount], [isCompleted], [OrderDate], [DIspatched], [DispatchedDate], [Shipped], [ShippingDate], [Deliver], [DeliveryDate], [Notes], [CancelOrder]) VALUES (2, 1, 2, 1, 0, 0, 100, 1, CAST(N'2022-09-11 17:57:16.727' AS DateTime), 1, CAST(N'2022-09-12 23:43:16.727' AS DateTime), 0, NULL, 1, CAST(N'2022-09-13 23:00:16.727' AS DateTime), NULL, 0)
INSERT [dbo].[Order] ([OrderID], [CustomerID], [PaymentID], [ShippingID], [Discount], [Taxes], [TotalAmount], [isCompleted], [OrderDate], [DIspatched], [DispatchedDate], [Shipped], [ShippingDate], [Deliver], [DeliveryDate], [Notes], [CancelOrder]) VALUES (3, 2, 3, 3, 0, 0, 1500, 1, CAST(N'2021-09-11 18:01:33.653' AS DateTime), 1, CAST(N'2021-09-12 18:46:18.727' AS DateTime), 0, NULL, 0, NULL, NULL, 0)
INSERT [dbo].[Order] ([OrderID], [CustomerID], [PaymentID], [ShippingID], [Discount], [Taxes], [TotalAmount], [isCompleted], [OrderDate], [DIspatched], [DispatchedDate], [Shipped], [ShippingDate], [Deliver], [DeliveryDate], [Notes], [CancelOrder]) VALUES (4, 3, 4, 2, 0, 0, 1500, 1, CAST(N'2021-07-11 18:01:33.653' AS DateTime), 1, CAST(N'2021-07-12 18:46:18.727' AS DateTime), 0, NULL, 0, NULL, NULL, 0)
SET IDENTITY_INSERT [dbo].[OrderDetails] ON 

INSERT [dbo].[OrderDetails] ([OrderDetailsID], [OrderID], [ProductID], [UnitPrice], [Quantity], [Discount], [TotalAmount], [OrderDate]) VALUES (1, 1, 1, CAST(20 AS Decimal(18, 0)), 1, NULL, CAST(20 AS Decimal(18, 0)), NULL)
INSERT [dbo].[OrderDetails] ([OrderDetailsID], [OrderID], [ProductID], [UnitPrice], [Quantity], [Discount], [TotalAmount], [OrderDate]) VALUES (2, 2, 2, CAST(100 AS Decimal(18, 0)), 1, NULL, CAST(100 AS Decimal(18, 0)), NULL)
INSERT [dbo].[OrderDetails] ([OrderDetailsID], [OrderID], [ProductID], [UnitPrice], [Quantity], [Discount], [TotalAmount], [OrderDate]) VALUES (3, 3, 4, CAST(1500 AS Decimal(18, 0)), 1, NULL, CAST(1500 AS Decimal(18, 0)), NULL)
INSERT [dbo].[OrderDetails] ([OrderDetailsID], [OrderID], [ProductID], [UnitPrice], [Quantity], [Discount], [TotalAmount], [OrderDate]) VALUES (4, 4, 4, CAST(1500 AS Decimal(18, 0)), 1, NULL, CAST(1500 AS Decimal(18, 0)), NULL)
SET IDENTITY_INSERT [dbo].[OrderDetails] OFF
INSERT [dbo].[Payment] ([PaymentID], [Type], [CreditAmount], [DebitAmount], [Balance], [PaymentDateTime]) VALUES (1, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Payment] ([PaymentID], [Type], [CreditAmount], [DebitAmount], [Balance], [PaymentDateTime]) VALUES (2, 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Payment] ([PaymentID], [Type], [CreditAmount], [DebitAmount], [Balance], [PaymentDateTime]) VALUES (3, 2, NULL, NULL, NULL, NULL)
INSERT [dbo].[Payment] ([PaymentID], [Type], [CreditAmount], [DebitAmount], [Balance], [PaymentDateTime]) VALUES (4, 1, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[PaymentType] ON 

INSERT [dbo].[PaymentType] ([PayTypeID], [TypeName], [Description]) VALUES (1, N'Paypal', NULL)
INSERT [dbo].[PaymentType] ([PayTypeID], [TypeName], [Description]) VALUES (2, N'Visa', NULL)
INSERT [dbo].[PaymentType] ([PayTypeID], [TypeName], [Description]) VALUES (3, N'Master Card', NULL)
SET IDENTITY_INSERT [dbo].[PaymentType] OFF
SET IDENTITY_INSERT [dbo].[Products] ON 
INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (1, N'Cs Go Full Account', 1, 1, 1, NULL, CAST(40 AS Decimal(18, 0)), CAST(50 AS Decimal(18, 0)), NULL, NULL, NULL,			3, NULL, 1, N'/Content/img/Game_Accounts/csgoaccount1.png', N'cs go img', 1, N'SALE!', N'aa-sale', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (2, N'20 Skins account', 1, 1, 1, NULL, CAST(15 AS Decimal(18, 0)), CAST(20 AS Decimal(18, 0)), NULL, NULL, NULL,				1, NULL, 1, N'/Content/img/Game_Accounts/csgoaccount2.png', N'cs go img', 1, N'SALE!', N'aa-sale', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (3, N'40 Skins + Gold Nova II', 1, 1, 1, NULL, CAST(50 AS Decimal(18, 0)), NULL, NULL, NULL, NULL,								2, NULL, 1, N'/Content/img/Game_Accounts/csgoaccount3.png', N'cs go img', 1, N'HOT!', N'aa-hot', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (4, N'Gold Butterfly', 1, 1, 1, NULL, CAST(1200 AS Decimal(18, 0)), NULL, NULL, NULL, NULL,									0, NULL, 1, N'/Content/img/Game_Accounts/csgoaccount5.png', N'cs go img', 1, N'SOLD OUT', N'aa-sold-out', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (5, N'Pubg Mobile Full Account', 1, 1, 2, NULL, CAST(100 AS Decimal(18, 0)), NULL, NULL, NULL, NULL,							3, NULL, 1, N'/Content/img/Game_Accounts/pmobile.png', N'pubg mobile img', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (6, N'Pubg Mobile 14rp Full', 1, 1, 2, NULL, CAST(75 AS Decimal(18, 0)), CAST(90 AS Decimal(18, 0)), NULL, NULL, NULL,			5, NULL, 1, N'/Content/img/Game_Accounts/pmobile2.png', N'pubg mobile img', 1, N'HOT!', N'aa-hot', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (7, N'40 skins + Prime', 1, 1, 2, NULL, CAST(37 AS Decimal(18, 0)), NULL, NULL, NULL, NULL,									1, NULL, 1, N'/Content/img/Game_Accounts/pmobile3.png', N'pubg mobile img', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (8, N'Fresh Account', 1, 1, 2, NULL, CAST(50 AS Decimal(18, 0)), NULL, NULL, NULL, NULL,										7, NULL, 1, N'/Content/img/Game_Accounts/pmobile4.png', N'pubg mobile img', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (9, N'Unity Project', 1, 2, 6, NULL, CAST(990 AS Decimal(18, 0)), NULL, NULL, NULL, NULL,										3, NULL, 1, N'/Content/img/Game_Accounts/unityproject1.png', N'unity img', 1, N'SALE!', N'aa-sale', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (10, N'Black Force Unity Project', 1, 2, 7, NULL, CAST(500 AS Decimal(18, 0)), CAST(650 AS Decimal(18, 0)), NULL, NULL, NULL,  1, NULL, 1, N'/Content/img/Game_Accounts/blackforce.png', N'unity img', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (11, N'Race King Unity Project', 1, 2, 10, NULL, CAST(750 AS Decimal(18, 0)), NULL, NULL, NULL, NULL,							1, NULL, 1, N'/Content/img/Game_Accounts/raceking.png', N'unity img', 1, N'HOT!', N'aa-hot', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (12, N'Football Unity Project', 1, 2, 6, NULL, CAST(400 AS Decimal(18, 0)), NULL, NULL, NULL, NULL,							1, NULL, 1, N'/Content/img/Game_Accounts/unityproject1.png', N'unity img', 1, N'SALE!', N'aa-sale', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (13, N'Prime Plus + Vector Skin', 1, 1, 3, NULL, CAST(5 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)), NULL, NULL, NULL,		1, NULL, 1, N'/Content/img/Game_Accounts/codmobile.png', N'call of duty img', 1, N'SALE!', N'aa-sale', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (14, N'BB 13 LVL + Full', 1, 5, 17, NULL, CAST(19 AS Decimal(18, 0)), NULL, NULL, NULL, NULL,									7, NULL, 1, N'/Content/img/Game_Accounts/coc.png', N'clash of clans img', 1, N'HOT!', N'aa-hot', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (15, N'Legendary Cards Full', 1, 5, 15, NULL, CAST(25 AS Decimal(18, 0)), NULL, NULL, NULL, NULL,								0, NULL, 1, N'/Content/img/Game_Accounts/clashroyale.png', N'clash royale img', 1, N'SOLD OUT', N'aa-sold-out', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (16, N'Special Ops Rank + 30 skin', 1, 1, 5, NULL, CAST(30 AS Decimal(18, 0)), NULL, NULL, NULL, NULL,							2, NULL, 1, N'/Content/img/Game_Accounts/cops.png', N'critical ops img', 1, N'HOT!', N'aa-hot', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (17, N'GTA V Fresh Account', 1, 6, 19, NULL, CAST(15 AS Decimal(18, 0)), NULL, NULL, NULL, NULL,								1, NULL, 1, N'/Content/img/Game_Accounts/gta5.png', N'gtaV img', 1, N'HOT!', N'aa-hot', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (18, N'Level 30 Account', 1, 5, 16, NULL, CAST(8 AS Decimal(18, 0)), NULL, NULL, NULL, NULL,									1, NULL, 1, N'/Content/img/Game_Accounts/hayday.png', N'hay day img', 1, N'SALE!', N'aa-sale', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (19, N'Level 25 Account', 1, 4, 13, NULL, CAST(18 AS Decimal(18, 0)), NULL, NULL, NULL, NULL,									1, NULL, 1, N'/Content/img/Game_Accounts/mlegends1.png', N'mobile legends img', 1, N'SALE!', N'aa-sale', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (20, N'Prime Pass + 15 character', 1, 4, 13, NULL, CAST(65 AS Decimal(18, 0)), CAST(75 AS Decimal(18, 0)), NULL, NULL, NULL,   1, NULL, 1, N'/Content/img/Game_Accounts/mlegends2.png', N'mobile legends img', 1, N'HOT!', N'aa-hot', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (21, N'Fifa 23 Account', 1, 3, 12, NULL, CAST(10 AS Decimal(18, 0)), CAST(30 AS Decimal(18, 0)), NULL, NULL, NULL,				2, NULL, 1, N'/Content/img/Game_Accounts/fifa23.png', N'fifa img', 1, N'HOT!', N'aa-hot', NULL, NULL, NULL, NULL, NULL, NULL, NULL)

--INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (22, N'Cs Go Full Account', 1, 7, 1, NULL, CAST(40 AS Decimal(18, 0)), CAST(50 AS Decimal(18, 0)), NULL, NULL, NULL, 1, NULL, 1, N'/Content/img/Game_Accounts/CsGo/csgoaccount1.png', N'cs go img', 1, N'SALE!', N'aa-sale', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
--INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (23, N'20 Skins account', 1, 7, 1, NULL, CAST(15 AS Decimal(18, 0)), CAST(20 AS Decimal(18, 0)), NULL, NULL, NULL, 1, NULL, 1, N'/Content/img/Game_Accounts/CsGo/csgoaccount2.png', N'cs go img', 1, N'SALE!', N'aa-sale', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
--INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (24, N'40 Skins + Gold Nova II', 1, 7, 1, NULL, CAST(50 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, 3, NULL, 1, N'/Content/img/Game_Accounts/CsGo/csgoaccount3.png', N'cs go img', 1, N'HOT!', N'aa-hot', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
--INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (25, N'Gold Butterfly', 1, 7, 1, NULL, CAST(1200 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, 0, NULL, 1, N'/Content/img/Game_Accounts/CsGo/csgoaccount5.png', N'cs go img', 1, N'SOLD OUT', N'aa-sold-out', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
--INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (26, N'Pubg Mobile Full Account', 1, 8, 2, NULL, CAST(100 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, 1, NULL, 1, N'/Content/img/Game_Accounts/PubgMobile/pmobile.png', N'pubg mobile img', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
--INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (27, N'Pubg Mobile 14rp Full', 1, 8, 2, NULL, CAST(75 AS Decimal(18, 0)), CAST(90 AS Decimal(18, 0)), NULL, NULL, NULL, 1, NULL, 1, N'/Content/img/Game_Accounts/PubgMobile/pmobile2.png', N'pubg mobile img', 1, N'HOT!', N'aa-hot', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
--INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (28, N'40 skins + Prime', 1, 8, 2, NULL, CAST(37 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, 1, NULL, 1, N'/Content/img/Game_Accounts/PubgMobile/pmobile3.png', N'pubg mobile img', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
--INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (29, N'Fresh Account', 1, 8, 2, NULL, CAST(50 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, 1, NULL, 1, N'/Content/img/Game_Accounts/PubgMobile/pmobile4.png', N'pubg mobile img', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
--INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (30, N'Unity Project', 1, 17, 6, NULL, CAST(990 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, 3, NULL, 1, N'/Content/img/Game_Projects/FootballPlayers/unityproject1.png', N'unity img', 1, N'SALE!', N'aa-sale', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
--INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (31, N'Black Force Unity Project', 1, 13, 7, NULL, CAST(500 AS Decimal(18, 0)), CAST(650 AS Decimal(18, 0)), NULL, NULL, NULL, 1, NULL, 1, N'/Content/img/Game_Projects/BlackForce/blackforce.png', N'unity img', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
--INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (32, N'Race King Unity Project', 1, 16, 10, NULL, CAST(750 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, 1, NULL, 1, N'/Content/img/Game_Projects/RaceKing/raceking.png', N'unity img', 1, N'HOT!', N'aa-hot', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
--INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (33, N'Football Unity Project', 1, 12, 6, NULL, CAST(400 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, 3, NULL, 1, N'/Content/img/Game_Projects/FootballPlayers/unityproject1.png', N'unity img', 1, N'SALE!', N'aa-sale', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
--INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (34, N'Prime Plus + Vector Skin', 1, 9, 3, NULL, CAST(5 AS Decimal(18, 0)), CAST(10 AS Decimal(18, 0)), NULL, NULL, NULL, 1, NULL, 1, N'/Content/img/Game_Accounts/CallOfDutyMobile/codmobile.png', N'call of duty img', 1, N'SALE!', N'aa-sale', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
--INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (35, N'BB 13 LVL + Full', 1, 23, 17, NULL, CAST(19 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, 3, NULL, 1, N'/Content/img/Game_Accounts/ClashOfClans/coc.png', N'clash of clans img', 1, N'HOT!', N'aa-hot', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
--INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (36, N'Legendary Cards Full', 1, 21, 15, NULL, CAST(25 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, 0, NULL, 1, N'/Content/img/Game_Accounts/ClashRoyale/clashroyale.png', N'clash royale img', 1, N'SOLD OUT', N'aa-sold-out', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
--INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (37, N'Special Ops Rank + 30 skin', 1, 11, 5, NULL, CAST(30 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, 1, NULL, 1, N'/Content/img/Game_Accounts/CriticalOps/cops.png', N'critical ops img', 1, N'HOT!', N'aa-hot', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
--INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (38, N'GTA V Fresh Account', 1, 25, 19, NULL, CAST(15 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, 5, NULL, 1, N'/Content/img/Game_Accounts/GtaV/gta5.png', N'gtaV img', 1, N'HOT!', N'aa-hot', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
--INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (39, N'Level 30 Account', 1, 22, 16, NULL, CAST(8 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, 1, NULL, 1, N'/Content/img/Game_Accounts/Hayday/hayday.png', N'hay day img', 1, N'SALE!', N'aa-sale', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
--INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (40, N'Level 25 Account', 1, 19, 13, NULL, CAST(18 AS Decimal(18, 0)), NULL, NULL, NULL, NULL, 1, NULL, 1, N'/Content/img/Game_Accounts/MobileLegends/mlegends1.png', N'mobile legends img', 1, N'SALE!', N'aa-sale', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
--INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (41, N'Prime Pass + 15 character', 1, 19, 13, NULL, CAST(65 AS Decimal(18, 0)), CAST(75 AS Decimal(18, 0)), NULL, NULL, NULL, 1, NULL, 1, N'/Content/img/Game_Accounts/MobileLegends/mlegends2.png', N'mobile legends img', 1, N'HOT!', N'aa-hot', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
--INSERT [dbo].[Products] ([ProductID], [Name], [SupplierID], [CategoryID], [SubCategoryID], [QuantityPerUnit], [UnitPrice], [OldPrice], [UnitWeight], [Size], [Discount], [UnitInStock], [UnitOnOrder], [ProductAvailable], [ImageURL], [AltText], [AddBadge], [OfferTitle], [OfferBadgeClass], [ShortDescription], [LongDescription], [Picture1], [Picture2], [Picture3], [Picture4], [Note]) VALUES (42, N'Fifa 23 Account', 1, 18, 12, NULL, CAST(10 AS Decimal(18, 0)), CAST(30 AS Decimal(18, 0)), NULL, NULL, NULL, 1, NULL, 1, N'/Content/img/Game_Accounts/Fifa/fifa23.png', N'fifa img', 1, N'HOT!', N'aa-hot', NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Products] OFF
SET IDENTITY_INSERT [dbo].[RecentlyViews] ON 

INSERT [dbo].[RecentlyViews] ([RViewID], [CustomerID], [ProductID], [ViewDate], [Note]) VALUES (1, 1, 1, CAST(N'2023-09-12 13:04:22.833' AS DateTime), NULL)
INSERT [dbo].[RecentlyViews] ([RViewID], [CustomerID], [ProductID], [ViewDate], [Note]) VALUES (2, 1, 1, CAST(N'2023-09-12 13:06:15.157' AS DateTime), NULL)
INSERT [dbo].[RecentlyViews] ([RViewID], [CustomerID], [ProductID], [ViewDate], [Note]) VALUES (3, 2, 1, CAST(N'2023-09-12 13:06:23.053' AS DateTime), NULL)
INSERT [dbo].[RecentlyViews] ([RViewID], [CustomerID], [ProductID], [ViewDate], [Note]) VALUES (4, 2, 2, CAST(N'2023-09-12 13:08:32.260' AS DateTime), NULL)
INSERT [dbo].[RecentlyViews] ([RViewID], [CustomerID], [ProductID], [ViewDate], [Note]) VALUES (5, 2, 2, CAST(N'2023-09-12 13:08:38.983' AS DateTime), NULL)
INSERT [dbo].[RecentlyViews] ([RViewID], [CustomerID], [ProductID], [ViewDate], [Note]) VALUES (6, 3, 3, CAST(N'2023-09-12 13:09:03.177' AS DateTime), NULL)
INSERT [dbo].[RecentlyViews] ([RViewID], [CustomerID], [ProductID], [ViewDate], [Note]) VALUES (7, 3, 3, CAST(N'2023-09-12 13:11:26.760' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[RecentlyViews] OFF
SET IDENTITY_INSERT [dbo].[Review] ON 

INSERT [dbo].[Review] ([ReviewID], [CustomerID], [ProductID], [Name], [Email], [Review], [Rate], [DateTime], [isDelete]) VALUES (1, 1, 1, N'Rufet Rasulov', N'rufetresulov@gmail.com', N'Good Product.', 4, CAST(N'2023-02-11 19:03:00.227' AS DateTime), NULL)
INSERT [dbo].[Review] ([ReviewID], [CustomerID], [ProductID], [Name], [Email], [Review], [Rate], [DateTime], [isDelete]) VALUES (2, 1, 4, N'Rufet Rasulov', N'rufetresulov@gmail.com', N'Not Bad.', 3, CAST(N'2023-03-01 13:03:00.227' AS DateTime), NULL)
INSERT [dbo].[Review] ([ReviewID], [CustomerID], [ProductID], [Name], [Email], [Review], [Rate], [DateTime], [isDelete]) VALUES (3, 1, 5, N'Rufet Rasulov', N'rufetresulov@gmail.com', N'Nice.', 4, CAST(N'2022-05-14 17:03:21.227' AS DateTime), NULL)
INSERT [dbo].[Review] ([ReviewID], [CustomerID], [ProductID], [Name], [Email], [Review], [Rate], [DateTime], [isDelete]) VALUES (4, 2, 2, N'Ferid Agayev', N'feridagayev@gmail.com', N'Nice', 5, CAST(N'2023-01-23 00:00:00.000' AS DateTime), NULL)
INSERT [dbo].[Review] ([ReviewID], [CustomerID], [ProductID], [Name], [Email], [Review], [Rate], [DateTime], [isDelete]) VALUES (5, 3, 3, N'Raqif Isgenderov', N'raqif123@gmail.com', N'Excellent product. thank you', 5, CAST(N'2020-07-14 00:00:00.000' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Review] OFF
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleID], [RoleName], [Description]) VALUES (1, N'Admin', N'All rights')
INSERT [dbo].[Roles] ([RoleID], [RoleName], [Description]) VALUES (2, N'Employee', N'Some rights')
INSERT [dbo].[Roles] ([RoleID], [RoleName], [Description]) VALUES (3, N'User', N'Some rights')
SET IDENTITY_INSERT [dbo].[Roles] OFF
INSERT [dbo].[ShippingDetails] ([ShippingID], [FirstName], [LastName], [Email], [Mobile], [Address], [Province], [City], [PostCode]) VALUES (1, N'Rufet', N'Rasulov', N'rufetresulov@gmail.com', N'+994509873423', N'Baku', N'Baku', N'Azerbaijan', N'1001')
INSERT [dbo].[ShippingDetails] ([ShippingID], [FirstName], [LastName], [Email], [Mobile], [Address], [Province], [City], [PostCode]) VALUES (2, N'Ferid', N'Agayev', N'feridagayev@gmail.com', N'+994517654409', N'Baku', N'Baku', N'Azerbaijan', N'1010')
INSERT [dbo].[ShippingDetails] ([ShippingID], [FirstName], [LastName], [Email], [Mobile], [Address], [Province], [City], [PostCode]) VALUES (3, N'Raqif', N'Isgenderov', N'raqif123@gmail.com', N'+994774556767', N'Baku', N'Baku', N'Azerbaijan', N'1007')
SET IDENTITY_INSERT [dbo].[SubCategory] ON 

INSERT [dbo].[SubCategory] ([SubCategoryID], [CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (1, 1, N'Cs:Go                ', NULL, NULL, NULL, NULL)
INSERT [dbo].[SubCategory] ([SubCategoryID], [CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (2, 1, N'Pubg Mobile          ', NULL, NULL, NULL, NULL)
INSERT [dbo].[SubCategory] ([SubCategoryID], [CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (3, 1, N'Call Of Duty Mobile  ', NULL, NULL, NULL, NULL)
INSERT [dbo].[SubCategory] ([SubCategoryID], [CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (4, 1, N'Call Of Duty Warzone ', NULL, NULL, NULL, NULL)
INSERT [dbo].[SubCategory] ([SubCategoryID], [CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (5, 1, N'Critical Ops         ', NULL, NULL, NULL, NULL)
INSERT [dbo].[SubCategory] ([SubCategoryID], [CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (6, 2, N'Football Players     ', NULL, NULL, NULL, NULL)
INSERT [dbo].[SubCategory] ([SubCategoryID], [CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (7, 2, N'Black Force          ', NULL, NULL, NULL, NULL)
INSERT [dbo].[SubCategory] ([SubCategoryID], [CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (8, 2, N'Drone Simulator      ', NULL, NULL, NULL, NULL)
INSERT [dbo].[SubCategory] ([SubCategoryID], [CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (9, 2, N'Car Ar Foundation    ', NULL, NULL, NULL, NULL)
INSERT [dbo].[SubCategory] ([SubCategoryID], [CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (10, 2, N'Race King           ', NULL, NULL, NULL, NULL)
INSERT [dbo].[SubCategory] ([SubCategoryID], [CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (11, 2, N'Earn Promo Code     ', NULL, NULL, NULL, NULL)
INSERT [dbo].[SubCategory] ([SubCategoryID], [CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (12, 3, N'Fifa                ', NULL, NULL, NULL, NULL)
INSERT [dbo].[SubCategory] ([SubCategoryID], [CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (13, 4, N'Mobile Legends      ', NULL, NULL, NULL, NULL)
INSERT [dbo].[SubCategory] ([SubCategoryID], [CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (14, 4, N'Assassins Creed     ', NULL, NULL, NULL, NULL)
INSERT [dbo].[SubCategory] ([SubCategoryID], [CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (15, 5, N'Clash Royale        ', NULL, NULL, NULL, NULL)
INSERT [dbo].[SubCategory] ([SubCategoryID], [CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (16, 5, N'Hay Day             ', NULL, NULL, NULL, NULL)
INSERT [dbo].[SubCategory] ([SubCategoryID], [CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (17, 5, N'Clash Of Clans      ', NULL, NULL, NULL, NULL)
INSERT [dbo].[SubCategory] ([SubCategoryID], [CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (18, 5, N'Fortnite            ', NULL, NULL, NULL, NULL)
INSERT [dbo].[SubCategory] ([SubCategoryID], [CategoryID], [Name], [Description], [Picture1], [Picture2], [isActive]) VALUES (19, 6, N'Grand Theft Auto V  ', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[SubCategory] OFF
SET IDENTITY_INSERT [dbo].[Suppliers] ON 
INSERT [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [Mobile], [Phone], [Fax], [Email], [City], [Country]) VALUES (1, N'FastSender Ltd', N'Robert', N'Marketing Manager', N'Wasington DC', 12087444182, 12087444182, NULL, N'robertmmc@gmail.com', N'Wasington DC', N'USA')
SET IDENTITY_INSERT [dbo].[Suppliers] OFF
SET IDENTITY_INSERT [dbo].[Wishlist] ON 
SET IDENTITY_INSERT [dbo].[Wishlist] OFF
ALTER TABLE [dbo].[admin_Login]  WITH CHECK ADD  CONSTRAINT [FK_admin_Login_admin_Employee] FOREIGN KEY([EmpID])
REFERENCES [dbo].[admin_Employee] ([EmpID])
GO
ALTER TABLE [dbo].[admin_Login] CHECK CONSTRAINT [FK_admin_Login_admin_Employee]
GO
ALTER TABLE [dbo].[admin_Login]  WITH CHECK ADD  CONSTRAINT [FK_admin_Login_Roles] FOREIGN KEY([RoleType])
REFERENCES [dbo].[Roles] ([RoleID])
GO
ALTER TABLE [dbo].[admin_Login] CHECK CONSTRAINT [FK_admin_Login_Roles]
GO
ALTER TABLE [dbo].[genPromoRight]  WITH CHECK ADD  CONSTRAINT [FK_genPromoRight_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[genPromoRight] CHECK CONSTRAINT [FK_genPromoRight_Categories]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Customers]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Payment] FOREIGN KEY([PaymentID])
REFERENCES [dbo].[Payment] ([PaymentID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Payment]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_ShippingDetails] FOREIGN KEY([ShippingID])
REFERENCES [dbo].[ShippingDetails] ([ShippingID])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_ShippingDetails]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Order]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Products]
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD  CONSTRAINT [FK_Payment_PaymentType] FOREIGN KEY([Type])
REFERENCES [dbo].[PaymentType] ([PayTypeID])
GO
ALTER TABLE [dbo].[Payment] CHECK CONSTRAINT [FK_Payment_PaymentType]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Categories]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_SubCategory] FOREIGN KEY([SubCategoryID])
REFERENCES [dbo].[SubCategory] ([SubCategoryID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_SubCategory]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [FK_Products_Suppliers] FOREIGN KEY([SupplierID])
REFERENCES [dbo].[Suppliers] ([SupplierID])
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [FK_Products_Suppliers]
GO
ALTER TABLE [dbo].[RecentlyViews]  WITH CHECK ADD  CONSTRAINT [FK_RecentlyViews_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[RecentlyViews] CHECK CONSTRAINT [FK_RecentlyViews_Customers]
GO
ALTER TABLE [dbo].[RecentlyViews]  WITH CHECK ADD  CONSTRAINT [FK_RecentlyViews_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[RecentlyViews] CHECK CONSTRAINT [FK_RecentlyViews_Products]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Customers]
GO
ALTER TABLE [dbo].[Review]  WITH CHECK ADD  CONSTRAINT [FK_Review_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Products]
GO
ALTER TABLE [dbo].[SubCategory]  WITH CHECK ADD  CONSTRAINT [FK_SubCategory_Categories] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Categories] ([CategoryID])
GO
ALTER TABLE [dbo].[SubCategory] CHECK CONSTRAINT [FK_SubCategory_Categories]
GO
ALTER TABLE [dbo].[Wishlist]  WITH CHECK ADD  CONSTRAINT [FK_Wishlist_Customers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[Customers] ([CustomerID])
GO
ALTER TABLE [dbo].[Wishlist] CHECK CONSTRAINT [FK_Wishlist_Customers]
GO
ALTER TABLE [dbo].[Wishlist]  WITH CHECK ADD  CONSTRAINT [FK_Wishlist_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[Wishlist] CHECK CONSTRAINT [FK_Wishlist_Products]
GO
USE [master]
GO
ALTER DATABASE [GameHub] SET  READ_WRITE 
GO

USE [master]
GO
/****** Object:  Database [rsmdb]    Script Date: 19.05.2019 18:46:52 ******/
CREATE DATABASE [rsmdb]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'rsmdb', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\rsmdb.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'rsmdb_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\rsmdb_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [rsmdb] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [rsmdb].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [rsmdb] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [rsmdb] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [rsmdb] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [rsmdb] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [rsmdb] SET ARITHABORT OFF 
GO
ALTER DATABASE [rsmdb] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [rsmdb] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [rsmdb] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [rsmdb] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [rsmdb] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [rsmdb] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [rsmdb] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [rsmdb] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [rsmdb] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [rsmdb] SET  DISABLE_BROKER 
GO
ALTER DATABASE [rsmdb] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [rsmdb] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [rsmdb] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [rsmdb] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [rsmdb] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [rsmdb] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [rsmdb] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [rsmdb] SET RECOVERY FULL 
GO
ALTER DATABASE [rsmdb] SET  MULTI_USER 
GO
ALTER DATABASE [rsmdb] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [rsmdb] SET DB_CHAINING OFF 
GO
ALTER DATABASE [rsmdb] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [rsmdb] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [rsmdb] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'rsmdb', N'ON'
GO
ALTER DATABASE [rsmdb] SET QUERY_STORE = OFF
GO
USE [rsmdb]
GO
ALTER DATABASE SCOPED CONFIGURATION SET IDENTITY_CACHE = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [rsmdb]
GO
/****** Object:  Table [dbo].[Image]    Script Date: 19.05.2019 18:46:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Image](
	[ImageId] [int] NOT NULL,
	[FilePath] [nvarchar](max) NOT NULL,
 CONSTRAINT [PK_Image] PRIMARY KEY CLUSTERED 
(
	[ImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[getDishImage]    Script Date: 19.05.2019 18:46:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[getDishImage] (@imageId INT)
RETURNS TABLE
AS
RETURN
   SELECT TOP 1 FilePath FROM Image
      WHERE ImageId = @imageId
GO
/****** Object:  Table [dbo].[Dish]    Script Date: 19.05.2019 18:46:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dish](
	[DishId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Description] [varchar](300) NULL,
	[Cost] [float] NULL,
	[Weight] [float] NULL,
	[NutritionalValue] [varchar](50) NULL,
	[IsAvailable] [bit] NOT NULL,
	[DishCategoryId] [int] NOT NULL,
 CONSTRAINT [PK_Dish_Id] PRIMARY KEY CLUSTERED 
(
	[DishId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DishCategory]    Script Date: 19.05.2019 18:46:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DishCategory](
	[DishCategoryId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_DishCategory_Id] PRIMARY KEY CLUSTERED 
(
	[DishCategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DishImage]    Script Date: 19.05.2019 18:46:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DishImage](
	[DishImageId] [int] NOT NULL,
	[ImageId] [int] NOT NULL,
	[DishId] [int] NOT NULL,
 CONSTRAINT [PK_DishImage] PRIMARY KEY CLUSTERED 
(
	[DishImageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[getDishes]    Script Date: 19.05.2019 18:46:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[getDishes]()
RETURNS TABLE
AS
RETURN
   SELECT        dbo.Dish.DishId, dbo.Dish.Name, dbo.Dish.Description, dbo.Dish.Cost, dbo.Dish.Weight, dbo.Dish.NutritionalValue, dbo.Dish.IsAvailable, dbo.DishImage.DishImageId, dbo.DishImage.ImageId, 
                         dbo.DishCategory.Name AS CatogoryName
FROM            dbo.Dish
INNER JOIN
                         dbo.DishCategory ON dbo.Dish.DishCategoryId = dbo.DishCategory.DishCategoryId
LEFT OUTER JOIN
                         dbo.DishImage ON dbo.Dish.DishId = dbo.DishImage.DishId
where dish.IsAvailable = 1
GO
/****** Object:  Table [dbo].[DishIngredient]    Script Date: 19.05.2019 18:46:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DishIngredient](
	[DishIngredientId] [int] IDENTITY(1,1) NOT NULL,
	[IngredientId] [int] NOT NULL,
	[DishId] [int] NOT NULL,
 CONSTRAINT [PK_DishIngredient_Id] PRIMARY KEY CLUSTERED 
(
	[DishIngredientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employee]    Script Date: 19.05.2019 18:46:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee](
	[EmployeeId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[Surname] [varchar](50) NOT NULL,
	[Birthday] [date] NULL,
	[Telephone] [varchar](50) NULL,
	[PositionId] [int] NOT NULL,
	[UserId] [int] NOT NULL,
 CONSTRAINT [PK_Employee_Id] PRIMARY KEY CLUSTERED 
(
	[EmployeeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ingredient]    Script Date: 19.05.2019 18:46:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ingredient](
	[IngredientId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Ingredient_Id] PRIMARY KEY CLUSTERED 
(
	[IngredientId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[TableNo] [int] NOT NULL,
	[Created] [datetimeoffset](7) NOT NULL,
	[GuestName] [varchar](50) NOT NULL,
	[OrderStatusId] [int] NOT NULL,
	[WaiterId] [int] NULL,
 CONSTRAINT [PK_Order_Id] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDish]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDish](
	[OrderDishId] [int] IDENTITY(1,1) NOT NULL,
	[IsReady] [bit] NOT NULL,
	[OrderId] [int] NOT NULL,
	[DishId] [int] NOT NULL,
	[CookId] [int] NULL,
	[Count] [int] NULL,
 CONSTRAINT [PK_OrderDish_Id] PRIMARY KEY CLUSTERED 
(
	[OrderDishId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderStatus](
	[OrderStatusId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_OrderStatus_Id] PRIMARY KEY CLUSTERED 
(
	[OrderStatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Position]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Position](
	[PositionId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Position_Id] PRIMARY KEY CLUSTERED 
(
	[PositionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_Role_Id] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[RoleId] [int] NOT NULL,
 CONSTRAINT [PK_User_Id] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Dish] ON 

INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (1, N'Chicken Soup', N'This soup will warm your heart.', 20, 200, N'100', 1, 1)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (3, N'Mushroom soup', N'The best soup in town.', 30, 250, N'240', 1, 1)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (4, N'Tomato soup', N'Award-winning mouth-watering soup', 40, 300, N'460', 1, 1)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (6, N'Chili soup', N'This super-hot soup will make you cry. ', 26, 200, N'200', 1, 1)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (8, N'Avocado soup', N'For true hipsters', 30, 150, N'150', 1, 1)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (10, N'Miso soup', N'Straight from Japan', 25, 200, N'200', 1, 1)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (11, N'Greek salad', N'Made with love and olives, tomatoes, feta and cucumbers', 40, 120, N'120', 1, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (12, N'Mimosa salad', N'Imagine living in USSR', 20, 200, N'330', 1, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (13, N'Nicoise salad', N'In case you need some french vibes', 20, 150, N'132', 1, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (18, N'test dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (20, N'test dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (21, N'Waldorf salad', N'Better than in Waldorf hotel', 30, 240, N'200', 1, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (22, N'Lasagnette', N'The best pasta in town', 35, 200, N'300', 0, 3)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (24, N'Sagne ''ncannulate', N'You may not be able to pronounce this name but this pasta is very tasty', 27, 267, N'333', 1, 3)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (25, N'Stracciatella gelato', N'Chocolate & chill, anyone?', 15, 120, N'120', 1, 4)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (26, N'Omelette au fromage', N'Have you watched Dexter''s lab too?', 15, 125, N'105', 1, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (27, N'Spaghetti bolognese', N'Italian goodness', 23, 200, N'357', 1, 3)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (28, N'Cinnamon Latte', N'Can you smell the cinnamon?', 200, 120, N'123', 1, 8)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (29, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (30, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (31, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (32, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (33, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (34, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (35, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (36, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (37, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (38, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (39, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (40, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (41, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (42, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (43, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (44, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (45, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (46, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (47, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (48, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (49, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (50, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (51, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (52, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (53, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (54, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (55, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (56, N'test book', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (57, N'test dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (58, N'test dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (59, N'test dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (60, N'test dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (61, N'test dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (62, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (63, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (64, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (65, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (66, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (68, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (70, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (72, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (74, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (76, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (77, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (78, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (79, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (80, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (82, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (84, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (86, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (88, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (90, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (92, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (94, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (96, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (98, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (100, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (102, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (104, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (106, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (108, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (110, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (112, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (114, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (116, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (118, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (120, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (122, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (124, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (126, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (128, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (130, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (132, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (134, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (136, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (138, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (140, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (142, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (144, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (146, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (148, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
GO
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (150, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (152, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (154, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (156, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (158, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (160, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (162, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (164, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (166, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (168, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (170, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (172, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (174, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (176, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (178, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (180, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (182, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (184, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (186, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (188, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (190, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (192, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (194, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (196, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (198, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (200, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (202, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (204, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (206, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (208, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (210, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (212, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (214, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (216, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (218, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (220, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (222, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (224, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (226, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (228, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (230, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (232, N'test put dish', N'test description', 200, 400, N'300', 0, 2)
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (234, N'test dish', N'test description', 200, 400, N'300', 0, 2)
SET IDENTITY_INSERT [dbo].[Dish] OFF
SET IDENTITY_INSERT [dbo].[DishCategory] ON 

INSERT [dbo].[DishCategory] ([DishCategoryId], [Name]) VALUES (1, N'Soup')
INSERT [dbo].[DishCategory] ([DishCategoryId], [Name]) VALUES (2, N'Salad')
INSERT [dbo].[DishCategory] ([DishCategoryId], [Name]) VALUES (3, N'Pasta')
INSERT [dbo].[DishCategory] ([DishCategoryId], [Name]) VALUES (4, N'Dessert')
INSERT [dbo].[DishCategory] ([DishCategoryId], [Name]) VALUES (5, N'Meat')
INSERT [dbo].[DishCategory] ([DishCategoryId], [Name]) VALUES (6, N'Sandwich')
INSERT [dbo].[DishCategory] ([DishCategoryId], [Name]) VALUES (7, N'Pizza')
INSERT [dbo].[DishCategory] ([DishCategoryId], [Name]) VALUES (8, N'Drinks')
INSERT [dbo].[DishCategory] ([DishCategoryId], [Name]) VALUES (9, N'Fish')
SET IDENTITY_INSERT [dbo].[DishCategory] OFF
INSERT [dbo].[DishImage] ([DishImageId], [ImageId], [DishId]) VALUES (1, 1, 1)
INSERT [dbo].[DishImage] ([DishImageId], [ImageId], [DishId]) VALUES (2, 2, 3)
INSERT [dbo].[DishImage] ([DishImageId], [ImageId], [DishId]) VALUES (4, 4, 4)
INSERT [dbo].[DishImage] ([DishImageId], [ImageId], [DishId]) VALUES (5, 5, 6)
INSERT [dbo].[DishImage] ([DishImageId], [ImageId], [DishId]) VALUES (6, 6, 8)
INSERT [dbo].[DishImage] ([DishImageId], [ImageId], [DishId]) VALUES (7, 7, 10)
INSERT [dbo].[DishImage] ([DishImageId], [ImageId], [DishId]) VALUES (8, 8, 11)
INSERT [dbo].[DishImage] ([DishImageId], [ImageId], [DishId]) VALUES (9, 9, 13)
INSERT [dbo].[DishImage] ([DishImageId], [ImageId], [DishId]) VALUES (10, 10, 12)
INSERT [dbo].[DishImage] ([DishImageId], [ImageId], [DishId]) VALUES (11, 11, 20)
INSERT [dbo].[DishImage] ([DishImageId], [ImageId], [DishId]) VALUES (12, 12, 18)
INSERT [dbo].[DishImage] ([DishImageId], [ImageId], [DishId]) VALUES (13, 13, 24)
INSERT [dbo].[DishImage] ([DishImageId], [ImageId], [DishId]) VALUES (14, 14, 25)
INSERT [dbo].[DishImage] ([DishImageId], [ImageId], [DishId]) VALUES (15, 16, 21)
SET IDENTITY_INSERT [dbo].[Employee] ON 

INSERT [dbo].[Employee] ([EmployeeId], [Name], [Surname], [Birthday], [Telephone], [PositionId], [UserId]) VALUES (3, N'John', N'Smith', CAST(N'1978-08-09' AS Date), N'78524896242', 1, 1)
INSERT [dbo].[Employee] ([EmployeeId], [Name], [Surname], [Birthday], [Telephone], [PositionId], [UserId]) VALUES (4, N'Robert', N'Black', CAST(N'1985-06-06' AS Date), N'23456783456', 2, 2)
INSERT [dbo].[Employee] ([EmployeeId], [Name], [Surname], [Birthday], [Telephone], [PositionId], [UserId]) VALUES (5, N'Dumbledore', N'', CAST(N'1950-05-05' AS Date), N'32323232323', 3, 3)
INSERT [dbo].[Employee] ([EmployeeId], [Name], [Surname], [Birthday], [Telephone], [PositionId], [UserId]) VALUES (6, N'Sabrina', N'Spellman', CAST(N'1999-11-22' AS Date), N'66666666666', 3, 3)
INSERT [dbo].[Employee] ([EmployeeId], [Name], [Surname], [Birthday], [Telephone], [PositionId], [UserId]) VALUES (7, N'Natasha', N'Boroduik', CAST(N'1998-12-01' AS Date), N'13124235345', 4, 7)
INSERT [dbo].[Employee] ([EmployeeId], [Name], [Surname], [Birthday], [Telephone], [PositionId], [UserId]) VALUES (8, N'Julia', N'Marhun', CAST(N'1999-01-02' AS Date), N'23232323232', 1, 8)
INSERT [dbo].[Employee] ([EmployeeId], [Name], [Surname], [Birthday], [Telephone], [PositionId], [UserId]) VALUES (9, N'Mia', N'Wilson', CAST(N'1997-05-07' AS Date), N'12131313133', 2, 6)
INSERT [dbo].[Employee] ([EmployeeId], [Name], [Surname], [Birthday], [Telephone], [PositionId], [UserId]) VALUES (11, N'Nadim', N'Blade', CAST(N'1998-12-28' AS Date), N'24235435453', 2, 9)
SET IDENTITY_INSERT [dbo].[Employee] OFF
INSERT [dbo].[Image] ([ImageId], [FilePath]) VALUES (1, N'chicken-soup.jpg')
INSERT [dbo].[Image] ([ImageId], [FilePath]) VALUES (2, N'mushroom-soup.jpg')
INSERT [dbo].[Image] ([ImageId], [FilePath]) VALUES (3, N'no-picture.jpg')
INSERT [dbo].[Image] ([ImageId], [FilePath]) VALUES (4, N'tomato-soup.jpg')
INSERT [dbo].[Image] ([ImageId], [FilePath]) VALUES (5, N'chili-soup.jpg')
INSERT [dbo].[Image] ([ImageId], [FilePath]) VALUES (6, N'avocado-soup.jpg')
INSERT [dbo].[Image] ([ImageId], [FilePath]) VALUES (7, N'miso-soup.jpg')
INSERT [dbo].[Image] ([ImageId], [FilePath]) VALUES (8, N'greek-salad.jpg')
INSERT [dbo].[Image] ([ImageId], [FilePath]) VALUES (9, N'lasagnette.jpg')
INSERT [dbo].[Image] ([ImageId], [FilePath]) VALUES (10, N'mimosa-salad.jpg')
INSERT [dbo].[Image] ([ImageId], [FilePath]) VALUES (11, N'nicoise-salad.jpg')
INSERT [dbo].[Image] ([ImageId], [FilePath]) VALUES (12, N'pasta-salad.jpg')
INSERT [dbo].[Image] ([ImageId], [FilePath]) VALUES (13, N'sagne-ncannulate.jpg')
INSERT [dbo].[Image] ([ImageId], [FilePath]) VALUES (14, N'stracciatella-gelato.jpg')
INSERT [dbo].[Image] ([ImageId], [FilePath]) VALUES (15, N'tam-phonlamai-ruam.jpg')
INSERT [dbo].[Image] ([ImageId], [FilePath]) VALUES (16, N'waldorf-salad.png')
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([OrderId], [TableNo], [Created], [GuestName], [OrderStatusId], [WaiterId]) VALUES (3, 1, CAST(N'2018-08-18T00:00:00.0000000+03:00' AS DateTimeOffset), N'Max', 1, 3)
SET IDENTITY_INSERT [dbo].[Order] OFF
SET IDENTITY_INSERT [dbo].[OrderDish] ON 

INSERT [dbo].[OrderDish] ([OrderDishId], [IsReady], [OrderId], [DishId], [CookId], [Count]) VALUES (3, 0, 3, 1, 4, 5)
INSERT [dbo].[OrderDish] ([OrderDishId], [IsReady], [OrderId], [DishId], [CookId], [Count]) VALUES (6, 0, 3, 3, NULL, 0)
INSERT [dbo].[OrderDish] ([OrderDishId], [IsReady], [OrderId], [DishId], [CookId], [Count]) VALUES (7, 0, 3, 4, NULL, 0)
INSERT [dbo].[OrderDish] ([OrderDishId], [IsReady], [OrderId], [DishId], [CookId], [Count]) VALUES (9, 0, 3, 6, NULL, 1)
SET IDENTITY_INSERT [dbo].[OrderDish] OFF
SET IDENTITY_INSERT [dbo].[OrderStatus] ON 

INSERT [dbo].[OrderStatus] ([OrderStatusId], [Name]) VALUES (1, N'Pending')
INSERT [dbo].[OrderStatus] ([OrderStatusId], [Name]) VALUES (2, N'IsReady')
INSERT [dbo].[OrderStatus] ([OrderStatusId], [Name]) VALUES (3, N'AwaitingPayment')
INSERT [dbo].[OrderStatus] ([OrderStatusId], [Name]) VALUES (4, N'Paid')
SET IDENTITY_INSERT [dbo].[OrderStatus] OFF
SET IDENTITY_INSERT [dbo].[Position] ON 

INSERT [dbo].[Position] ([PositionId], [Name]) VALUES (1, N'chief')
INSERT [dbo].[Position] ([PositionId], [Name]) VALUES (2, N'cook')
INSERT [dbo].[Position] ([PositionId], [Name]) VALUES (3, N'waiter')
INSERT [dbo].[Position] ([PositionId], [Name]) VALUES (4, N'manager')
SET IDENTITY_INSERT [dbo].[Position] OFF
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleId], [Name]) VALUES (1, N'guest')
INSERT [dbo].[Role] ([RoleId], [Name]) VALUES (2, N'admin')
INSERT [dbo].[Role] ([RoleId], [Name]) VALUES (3, N'cook')
INSERT [dbo].[Role] ([RoleId], [Name]) VALUES (4, N'waiter')
SET IDENTITY_INSERT [dbo].[Role] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserId], [Email], [Password], [RoleId]) VALUES (1, N'john@wilkins.com', N'12345678', 1)
INSERT [dbo].[User] ([UserId], [Email], [Password], [RoleId]) VALUES (2, N'mr.black@gmu.com', N'qwerty', 2)
INSERT [dbo].[User] ([UserId], [Email], [Password], [RoleId]) VALUES (3, N'dumbledore@pottermore.com', N'lemondrops', 3)
INSERT [dbo].[User] ([UserId], [Email], [Password], [RoleId]) VALUES (5, N'witch@witchysite.com', N'abracadabra', 4)
INSERT [dbo].[User] ([UserId], [Email], [Password], [RoleId]) VALUES (6, N'cool@me.com', N'coolcool', 4)
INSERT [dbo].[User] ([UserId], [Email], [Password], [RoleId]) VALUES (7, N'nat@nat.com', N'natasha', 3)
INSERT [dbo].[User] ([UserId], [Email], [Password], [RoleId]) VALUES (8, N'jul@jul.com', N'julia', 2)
INSERT [dbo].[User] ([UserId], [Email], [Password], [RoleId]) VALUES (9, N'diamond@blade.com', N'qwerty', 1)
SET IDENTITY_INSERT [dbo].[User] OFF
ALTER TABLE [dbo].[OrderDish] ADD  CONSTRAINT [DF_OrderDish_Count]  DEFAULT ((1)) FOR [Count]
GO
ALTER TABLE [dbo].[Dish]  WITH CHECK ADD  CONSTRAINT [FK_Dish_DishCategory_Id] FOREIGN KEY([DishCategoryId])
REFERENCES [dbo].[DishCategory] ([DishCategoryId])
GO
ALTER TABLE [dbo].[Dish] CHECK CONSTRAINT [FK_Dish_DishCategory_Id]
GO
ALTER TABLE [dbo].[DishImage]  WITH CHECK ADD  CONSTRAINT [FK_DishImage_Dish] FOREIGN KEY([DishId])
REFERENCES [dbo].[Dish] ([DishId])
GO
ALTER TABLE [dbo].[DishImage] CHECK CONSTRAINT [FK_DishImage_Dish]
GO
ALTER TABLE [dbo].[DishImage]  WITH CHECK ADD  CONSTRAINT [FK_DishImage_ImageId] FOREIGN KEY([ImageId])
REFERENCES [dbo].[Image] ([ImageId])
GO
ALTER TABLE [dbo].[DishImage] CHECK CONSTRAINT [FK_DishImage_ImageId]
GO
ALTER TABLE [dbo].[DishIngredient]  WITH CHECK ADD  CONSTRAINT [FK_DishIngredient_Dish_Id] FOREIGN KEY([DishId])
REFERENCES [dbo].[Dish] ([DishId])
GO
ALTER TABLE [dbo].[DishIngredient] CHECK CONSTRAINT [FK_DishIngredient_Dish_Id]
GO
ALTER TABLE [dbo].[DishIngredient]  WITH CHECK ADD  CONSTRAINT [FK_DishIngredient_Ingredient_Id] FOREIGN KEY([IngredientId])
REFERENCES [dbo].[Ingredient] ([IngredientId])
GO
ALTER TABLE [dbo].[DishIngredient] CHECK CONSTRAINT [FK_DishIngredient_Ingredient_Id]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_Position_Id] FOREIGN KEY([PositionId])
REFERENCES [dbo].[Position] ([PositionId])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_Position_Id]
GO
ALTER TABLE [dbo].[Employee]  WITH CHECK ADD  CONSTRAINT [FK_Employee_User_Id] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
GO
ALTER TABLE [dbo].[Employee] CHECK CONSTRAINT [FK_Employee_User_Id]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_OrderStatus_Id] FOREIGN KEY([OrderStatusId])
REFERENCES [dbo].[OrderStatus] ([OrderStatusId])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_OrderStatus_Id]
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_Waiter_Id] FOREIGN KEY([WaiterId])
REFERENCES [dbo].[Employee] ([EmployeeId])
GO
ALTER TABLE [dbo].[Order] CHECK CONSTRAINT [FK_Order_Waiter_Id]
GO
ALTER TABLE [dbo].[OrderDish]  WITH CHECK ADD  CONSTRAINT [FK_OrderDish_Dish_Id] FOREIGN KEY([DishId])
REFERENCES [dbo].[Dish] ([DishId])
GO
ALTER TABLE [dbo].[OrderDish] CHECK CONSTRAINT [FK_OrderDish_Dish_Id]
GO
ALTER TABLE [dbo].[OrderDish]  WITH CHECK ADD  CONSTRAINT [FK_OrderDish_Order_Id] FOREIGN KEY([OrderId])
REFERENCES [dbo].[Order] ([OrderId])
GO
ALTER TABLE [dbo].[OrderDish] CHECK CONSTRAINT [FK_OrderDish_Order_Id]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role_Id] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([RoleId])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role_Id]
GO
/****** Object:  StoredProcedure [dbo].[addDishToOrder]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[addDishToOrder] (
	@orderId int,
	@dishId int,
	@count int = 1,
	@orderDishId int output
)
AS
BEGIN
SET NOCOUNT ON;
IF EXISTS (SELECT * FROM OrderDish 
WHERE (OrderId = @orderId) AND (DishId = @dishId))
	BEGIN
	   UPDATE OrderDish set [Count] = @count
	   WHERE (OrderId = @orderId) AND (DishId = @dishId)
	END
ELSE
	BEGIN
	   INSERT INTO [dbo].OrderDish (IsReady, OrderId, DishId)
	   VALUES (0, @orderId, @dishId)
	   SET @orderDishId = SCOPE_IDENTITY()
	   RETURN @orderDishId
	END
END
GO
/****** Object:  StoredProcedure [dbo].[assignCookToDish]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[assignCookToDish] (
	@employeeId int,
	@dishId int,
	@orderId int
)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE [dbo].[OrderDish]
	   SET CookId = @employeeId
	 WHERE (OrderId = @orderId)
		AND (DishId = @dishId)
END
GO
/****** Object:  StoredProcedure [dbo].[assignWaiterToOrder]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[assignWaiterToOrder] (
	@waiterId int,
	@orderId int
)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE [dbo].[Order]
	   SET WaiterId = @waiterId
	 WHERE (OrderId = @orderId)
END
GO
/****** Object:  StoredProcedure [dbo].[authorizeUser]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[authorizeUser] (
	@email varchar(50),
	@password varchar(50)
)
AS
SELECT UserId
FROM [User]
WHERE (Email = @email) AND ([Password] = @password)
GO
/****** Object:  StoredProcedure [dbo].[createDish]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[createDish] (
	@name varchar(50),
	@description varchar(300),
	@cost float,
	@weight float,
	@nutritionalValue varchar(50),
	@isAvailable bit,
	@dishCategoryId int,
	@dishId int output
)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO [dbo].Dish (Dish.Name, Dish.Description, Cost, Dish.Weight, 
		NutritionalValue, IsAvailable, DishCategoryId)
	VALUES (@name, @description, @cost, @weight,
		@nutritionalValue, @isAvailable, @dishCategoryId)
	SET @dishId = SCOPE_IDENTITY()
	RETURN @dishId
END
GO
/****** Object:  StoredProcedure [dbo].[createOrder]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[createOrder] (
	@table int,
	@created datetimeoffset(7),
	@guestName varchar(50),
	@orderId int OUTPUT
)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO [dbo].[Order] (TableNo, Created, GuestName, OrderStatusId)
	VALUES (@table, @created, @guestName, 1)
	SET @orderId = SCOPE_IDENTITY()
	RETURN @orderId
END
GO
/****** Object:  StoredProcedure [dbo].[deleteDish]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[deleteDish] (
	@dishId int
)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE [dbo].[Dish]
	   SET [IsAvailable] = 0
	 WHERE Dish.DishId = @dishId
END
GO
/****** Object:  StoredProcedure [dbo].[getAllDishes]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[getAllDishes]
AS
SELECT Dish.DishId,
	Dish.Name,
	Cost,
	Weight,
	DishImage.ImageId,
	NutritionalValue,
	DishCategory.DishCategoryId as CategoryId,
	DishCategory.Name as CategoryName,
	IsAvailable,
	Description	
FROM Dish
left join DishCategory on 
	Dish.DishCategoryId = DishCategory.DishCategoryId
left outer join DishImage on Dish.DishId = DishImage.DishId
GO
/****** Object:  StoredProcedure [dbo].[getAvailableDishes]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getAvailableDishes]
AS
SELECT Dish.DishId,
	Dish.Name,
	Cost,
	Weight,
	DishImage.ImageId,
	NutritionalValue,
	DishCategory.Name as Category,
	Description	
FROM Dish
left join DishCategory on 
	Dish.DishCategoryId = DishCategory.DishCategoryId
left outer join DishImage on Dish.DishId = DishImage.DishId
where Dish.IsAvailable = 1
GO
/****** Object:  StoredProcedure [dbo].[getCategories]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[getCategories]
AS
SELECT [DishCategoryId] as Id
      ,[Name]
  FROM [rsmdb].[dbo].[DishCategory]
GO
/****** Object:  StoredProcedure [dbo].[getDish]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getDish] @dishId INT
AS
	SELECT * FROM Dish
	WHERE Dish.DishId = @dishId
GO
/****** Object:  StoredProcedure [dbo].[getEmployees]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getEmployees]
AS
SELECT EmployeeId,
	   Employee.Name, 
	   Surname,
	   Birthday,
	   Telephone,
	   Position.PositionId,
	   Position.Name as Position
FROM Employee
INNER JOIN Position ON
Employee.PositionId = Position.PositionId
GO
/****** Object:  StoredProcedure [dbo].[getImagePath]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getImagePath] @imageId INT
AS
	SELECT FilePath FROM Image
	WHERE Image.ImageId = @imageId
GO
/****** Object:  StoredProcedure [dbo].[getImages]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[getImages]
AS
SELECT [ImageId] as Id
      ,[FilePath]
  FROM [rsmdb].[dbo].[Image]
GO
/****** Object:  StoredProcedure [dbo].[getOrder]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[getOrder] (
	@orderId int
)
AS
SELECT OrderId,
	   TableNo,
	   WaiterId,
	   Created,
	   GuestName,
	   OrderStatus.OrderStatusId as StatusId,
	   OrderStatus.Name as Status
FROM [Order]
LEFT OUTER JOIN OrderStatus ON
[Order].OrderStatusId = OrderStatus.OrderStatusId
WHERE OrderId = @orderId
GO
/****** Object:  StoredProcedure [dbo].[getOrderDishes]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getOrderDishes] (
	@orderId int
)
AS
SELECT 
	Dish.DishId,
	Dish.Name,
	Cost,
	Weight,
	DishImage.ImageId,
	NutritionalValue,
	DishCategory.Name as Category,
	Description,
	IsReady,
	CookId,
	[Count]	 
FROM OrderDish
INNER JOIN Dish ON
	OrderDish.DishId = Dish.DishId
LEFT JOIN DishCategory on 
	Dish.DishCategoryId = DishCategory.DishCategoryId
LEFT OUTER JOIN DishImage on Dish.DishId = DishImage.DishId
WHERE (OrderId = @orderId) AND (OrderDish.[Count] > 0)
GO
/****** Object:  StoredProcedure [dbo].[getOrders]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getOrders]
AS
SELECT OrderId,
	   TableNo,
	   WaiterId,
	   Created,
	   GuestName,
	   OrderStatus.OrderStatusId as StatusId,
	   OrderStatus.Name as Status
FROM [Order]
LEFT OUTER JOIN OrderStatus ON
[Order].OrderStatusId = OrderStatus.OrderStatusId
GO
/****** Object:  StoredProcedure [dbo].[getUsers]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getUsers]
AS
SELECT *
FROM [User]
GO
/****** Object:  StoredProcedure [dbo].[updateDish]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[updateDish] (
	@dishId int,
	@name varchar(50),
	@description varchar(300),
	@cost float,
	@weight float,
	@nutritionalValue varchar(50),
	@isAvailable bit,
	@dishCategoryId int
)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE [dbo].[Dish]
	   SET [Name] = @name,
		   [Description] = @description,
		   [Cost] = @cost,
		   [Weight] = @weight,
		   [NutritionalValue] = @nutritionalValue,
		   [IsAvailable] = @isAvailable,
		   [DishCategoryId] = @dishCategoryId
	 WHERE Dish.DishId = @dishId
END
GO
/****** Object:  StoredProcedure [dbo].[updateDishName]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[updateDishName] (
	@dishId int,
	@name varchar(50)
)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE [dbo].[Dish]
	   SET [Name] = @name
	WHERE Dish.DishId = @dishId
END
GO
/****** Object:  StoredProcedure [dbo].[updateDishStatus]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[updateDishStatus] (
	@dishId int,
	@orderId int,
	@isReady bit
)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE [dbo].[OrderDish]
	   SET IsReady = @isReady
	 WHERE (OrderDish.DishId = @dishId)
		AND (OrderDish.OrderId = @orderId)
END
GO
/****** Object:  StoredProcedure [dbo].[updateOrder]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[updateOrder] (
	@orderId int,
	@table int,
	@guestName varchar(50),
	@waiterId int,
	@statusId int
)
AS
BEGIN
	UPDATE [dbo].[Order]
	   SET OrderStatusId = IsNull(@statusId, OrderStatusId),
		   TableNo = IsNull(@table, TableNo),
		   GuestName = IsNull(@guestName, GuestName),
		   WaiterId = IsNull( @waiterId, WaiterId)
	 WHERE (OrderId = @orderId)
END
GO
/****** Object:  StoredProcedure [dbo].[updateOrderStatus]    Script Date: 19.05.2019 18:46:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[updateOrderStatus] (
	@statusId int,
	@orderId int
)
AS
BEGIN
	SET NOCOUNT ON;
	UPDATE [dbo].[Order]
	   SET OrderStatusId = @statusId
	 WHERE (OrderId = @orderId)
END
GO
USE [master]
GO
ALTER DATABASE [rsmdb] SET  READ_WRITE 
GO

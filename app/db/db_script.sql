USE [master]
GO
/****** Object:  Database [rsmdb]    Script Date: 3/12/2019 11:39:34 AM ******/
CREATE DATABASE [rsmdb]

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
/****** Object:  Table [dbo].[Image]    Script Date: 3/12/2019 11:39:35 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[getDishImage]    Script Date: 3/12/2019 11:39:35 AM ******/
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
/****** Object:  Table [dbo].[Dish]    Script Date: 3/12/2019 11:39:35 AM ******/
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
/****** Object:  Table [dbo].[DishCategory]    Script Date: 3/12/2019 11:39:35 AM ******/
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
/****** Object:  Table [dbo].[DishImage]    Script Date: 3/12/2019 11:39:35 AM ******/
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
/****** Object:  UserDefinedFunction [dbo].[getDishes]    Script Date: 3/12/2019 11:39:35 AM ******/
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
/****** Object:  Table [dbo].[DishIngredient]    Script Date: 3/12/2019 11:39:35 AM ******/
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
/****** Object:  Table [dbo].[Employee]    Script Date: 3/12/2019 11:39:35 AM ******/
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
/****** Object:  Table [dbo].[Ingredient]    Script Date: 3/12/2019 11:39:35 AM ******/
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
/****** Object:  Table [dbo].[Order]    Script Date: 3/12/2019 11:39:35 AM ******/
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
	[WaiterId] [int] NOT NULL,
 CONSTRAINT [PK_Order_Id] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderDish]    Script Date: 3/12/2019 11:39:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDish](
	[OrderDishId] [int] IDENTITY(1,1) NOT NULL,
	[IsReady] [bit] NOT NULL,
	[OrderId] [int] NOT NULL,
	[DishId] [int] NOT NULL,
 CONSTRAINT [PK_OrderDish_Id] PRIMARY KEY CLUSTERED 
(
	[OrderDishId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 3/12/2019 11:39:35 AM ******/
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
/****** Object:  Table [dbo].[Position]    Script Date: 3/12/2019 11:39:35 AM ******/
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
/****** Object:  Table [dbo].[Role]    Script Date: 3/12/2019 11:39:35 AM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 3/12/2019 11:39:35 AM ******/
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
GO
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (1, N'Chicken Soup', N'This soup will warm your heart.', 20, 200, N'100', 1, 1)
GO
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (3, N'Mushroom soup', N'The best soup in town.', 30, 250, N'240', 1, 1)
GO
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (4, N'Tomato soup', N'Award-winning mouth-watering soup', 40, 300, N'460', 1, 1)
GO
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (6, N'Chili soup', N'This super-hot soup will make you cry. ', 26, 200, N'200', 1, 1)
GO
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (8, N'Avocado soup', N'For true hipsters', 30, 150, N'150', 1, 1)
GO
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (10, N'Miso soup', N'Straight from Japan', 25, 200, N'200', 1, 1)
GO
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (11, N'Greek salad', N'Made with love and olives, tomatoes, feta and cucumbers', 40, 120, N'120', 1, 2)
GO
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (12, N'Mimosa salad', N'Imagine living in USSR', 20, 200, N'330', 1, 2)
GO
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (13, N'Nicoise salad', N'In case you need some french vibes', 20, 150, N'132', 1, 2)
GO
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (18, N'Pasta salad', N'When you want to diet but also love pasta way too much', 45, 300, N'300', 1, 2)
GO
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (20, N'Tam phonlamai ruam', N'Fruity goodness just for you', 20, 270, N'280', 1, 2)
GO
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (21, N'Waldorf salad', N'Better than in Waldorf hotel', 30, 240, N'200', 1, 2)
GO
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (22, N'Lasagnette', N'The best pasta in town', 35, 200, N'300', 0, 3)
GO
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (24, N'Sagne ''ncannulate', N'You may not be able to pronounce this name but this pasta is very tasty', 27, 267, N'333', 1, 3)
GO
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (25, N'Stracciatella gelato', N'Chocolate & chill, anyone?', 15, 120, N'120', 1, 4)
GO
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (26, N'Omelette au fromage', N'Have you watched Dexter''s lab too?', 15, 125, N'105', 1, 2)
GO
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (27, N'Spaghetti bolognese', N'Italian goodness', 23, 200, N'357', 1, 3)
GO
INSERT [dbo].[Dish] ([DishId], [Name], [Description], [Cost], [Weight], [NutritionalValue], [IsAvailable], [DishCategoryId]) VALUES (28, N'Cinnamon Latte', N'Can you smell the cinnamon?', 200, 120, N'123', 1, 8)
GO
SET IDENTITY_INSERT [dbo].[Dish] OFF
GO
SET IDENTITY_INSERT [dbo].[DishCategory] ON 
GO
INSERT [dbo].[DishCategory] ([DishCategoryId], [Name]) VALUES (1, N'Soup')
GO
INSERT [dbo].[DishCategory] ([DishCategoryId], [Name]) VALUES (2, N'Salad')
GO
INSERT [dbo].[DishCategory] ([DishCategoryId], [Name]) VALUES (3, N'Pasta')
GO
INSERT [dbo].[DishCategory] ([DishCategoryId], [Name]) VALUES (4, N'Dessert')
GO
INSERT [dbo].[DishCategory] ([DishCategoryId], [Name]) VALUES (5, N'Meat')
GO
INSERT [dbo].[DishCategory] ([DishCategoryId], [Name]) VALUES (6, N'Sandwich')
GO
INSERT [dbo].[DishCategory] ([DishCategoryId], [Name]) VALUES (7, N'Pizza')
GO
INSERT [dbo].[DishCategory] ([DishCategoryId], [Name]) VALUES (8, N'Drinks')
GO
INSERT [dbo].[DishCategory] ([DishCategoryId], [Name]) VALUES (9, N'Fish')
GO
SET IDENTITY_INSERT [dbo].[DishCategory] OFF
GO
INSERT [dbo].[DishImage] ([DishImageId], [ImageId], [DishId]) VALUES (1, 1, 1)
GO
INSERT [dbo].[DishImage] ([DishImageId], [ImageId], [DishId]) VALUES (2, 2, 3)
GO
INSERT [dbo].[DishImage] ([DishImageId], [ImageId], [DishId]) VALUES (3, 4, 4)
GO
INSERT [dbo].[Image] ([ImageId], [FilePath]) VALUES (1, N'dishes/chicken-soup.jpg')
GO
INSERT [dbo].[Image] ([ImageId], [FilePath]) VALUES (2, N'dishes/mushroom-soup.jpg')
GO
INSERT [dbo].[Image] ([ImageId], [FilePath]) VALUES (3, N'no-picture.jpg')
GO
INSERT [dbo].[Image] ([ImageId], [FilePath]) VALUES (4, N'dishes/tomato-soup.jpg')
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
/****** Object:  StoredProcedure [dbo].[createDish]    Script Date: 3/12/2019 11:39:36 AM ******/
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
/****** Object:  StoredProcedure [dbo].[deleteDish]    Script Date: 3/12/2019 11:39:36 AM ******/
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
/****** Object:  StoredProcedure [dbo].[getAvailableDishes]    Script Date: 3/12/2019 11:39:36 AM ******/
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
/****** Object:  StoredProcedure [dbo].[getImagePath]    Script Date: 3/12/2019 11:39:36 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getImagePath] @imageId INT
AS
	SELECT FilePath FROM Image
	WHERE Image.ImageId = @imageId
GO
/****** Object:  StoredProcedure [dbo].[updateDish]    Script Date: 3/12/2019 11:39:36 AM ******/
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
/****** Object:  StoredProcedure [dbo].[updateDishName]    Script Date: 3/12/2019 11:39:36 AM ******/
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
USE [master]
GO
ALTER DATABASE [rsmdb] SET  READ_WRITE 
GO

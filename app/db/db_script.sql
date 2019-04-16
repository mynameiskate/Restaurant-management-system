USE [master]
GO
/****** Object:  Database [rsmdb]    Script Date: 4/16/2019 11:13:54 PM ******/
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
/****** Object:  Table [dbo].[Image]    Script Date: 4/16/2019 11:13:54 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[getDishImage]    Script Date: 4/16/2019 11:13:54 PM ******/
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
/****** Object:  Table [dbo].[Dish]    Script Date: 4/16/2019 11:13:54 PM ******/
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
/****** Object:  Table [dbo].[DishCategory]    Script Date: 4/16/2019 11:13:54 PM ******/
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
/****** Object:  Table [dbo].[DishImage]    Script Date: 4/16/2019 11:13:54 PM ******/
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
/****** Object:  UserDefinedFunction [dbo].[getDishes]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  Table [dbo].[DishIngredient]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  Table [dbo].[Employee]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  Table [dbo].[Ingredient]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  Table [dbo].[Order]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  Table [dbo].[OrderDish]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  Table [dbo].[OrderStatus]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  Table [dbo].[Position]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  Table [dbo].[Role]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  StoredProcedure [dbo].[addDishToOrder]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  StoredProcedure [dbo].[assignCookToDish]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  StoredProcedure [dbo].[assignWaiterToOrder]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  StoredProcedure [dbo].[authorizeUser]    Script Date: 4/16/2019 11:13:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[authorizeUser] (
	@email varchar(50),
	@password varchar(5)
)
AS
SELECT UserId
FROM [User]
WHERE (Email = @email) AND ([Password] = @password)
GO
/****** Object:  StoredProcedure [dbo].[createDish]    Script Date: 4/16/2019 11:13:55 PM ******/
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
	@dishCategoryId int
)
AS
BEGIN
	SET NOCOUNT ON;
	INSERT INTO [dbo].Dish (Dish.Name, Dish.Description, Cost, Dish.Weight, 
		NutritionalValue, IsAvailable, DishCategoryId)
	VALUES (@name, @description, @cost, @weight,
		@nutritionalValue, @isAvailable, @dishCategoryId)

	SELECT * FROM Dish WHERE Dish.DishId = SCOPE_IDENTITY();
END
GO
/****** Object:  StoredProcedure [dbo].[createOrder]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  StoredProcedure [dbo].[deleteDish]    Script Date: 4/16/2019 11:13:55 PM ******/
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
	DELETE FROM [dbo].[Dish]
	WHERE Dish.DishId = @dishId
END
GO
/****** Object:  StoredProcedure [dbo].[getAllDishes]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  StoredProcedure [dbo].[getAvailableDishes]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  StoredProcedure [dbo].[getCategories]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  StoredProcedure [dbo].[getDish]    Script Date: 4/16/2019 11:13:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[getDish] (
	@dishId int
)
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
FROM [Dish]
left join DishCategory on 
	Dish.DishCategoryId = DishCategory.DishCategoryId
left outer join DishImage on Dish.DishId = DishImage.DishId
WHERE Dish.DishId = @dishId
GO
/****** Object:  StoredProcedure [dbo].[getEmployees]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  StoredProcedure [dbo].[getImagePath]    Script Date: 4/16/2019 11:13:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[getImagePath] @imageId INT
AS
	SELECT FilePath FROM Image
	WHERE Image.ImageId = @imageId
GO
/****** Object:  StoredProcedure [dbo].[getOrder]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  StoredProcedure [dbo].[getOrderDishes]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  StoredProcedure [dbo].[getOrders]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  StoredProcedure [dbo].[updateDish]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  StoredProcedure [dbo].[updateDishName]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  StoredProcedure [dbo].[updateDishStatus]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  StoredProcedure [dbo].[updateOrder]    Script Date: 4/16/2019 11:13:55 PM ******/
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
/****** Object:  StoredProcedure [dbo].[updateOrderStatus]    Script Date: 4/16/2019 11:13:55 PM ******/
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

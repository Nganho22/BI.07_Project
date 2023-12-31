USE [master]
GO

/****** Object:  Database [BI07_MOVIE_STAGE]    Script Date: 12/17/2023 8:18:31 PM ******/
CREATE DATABASE [BI07_MOVIE_STAGE]
GO

USE [BI07_MOVIE_STAGE]
GO

/****** Object:  Table [dbo].[city] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[film](
	[FilmID] [nvarchar](255) NOT NULL,
	[Film Name] [nvarchar](255) NULL,
	[FilmCategoryID] [nvarchar](255) NULL,
	[Price] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[film_cate] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[film_cate](
	[FilmCategoryID] [nvarchar](255) NOT NULL,
	[Film Category] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[cinema] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cinema](
	[CinemaID] [nvarchar](255) NOT NULL,
	[Cinema Name] [nvarchar](255) NULL,
	[CityID] [nvarchar](255) NULL,
	[Capacity] [int] NULL,
	[Standard_Seats_price] [int] NULL,
	[VIP_Seats_price] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[city] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[city](
	[CityID] [nvarchar](255) NOT NULL,
	[CityName] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[film_sales_S1] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[film_sales_S1](
	[RevenueID] [nvarchar](255) NOT NULL,
	[FilmID] [nvarchar](255) NULL,
	[Cinema Name] [nvarchar](255) NULL,
	[total_sales] [int] NULL,
	[tickets_sold] [int] NULL,
	[Standard_Seats_sold] [int] NULL,
	[VIP_Seats_sold] [int] NULL,
	[Standard_Seats_out] [int] NULL,
	[VIP_Seats_out] [int] NULL,
	[tickets_out] [int] NULL,
	[occur_perc] [float] NULL,
	[ticket_use] [int] NULL,
	[date] [DATE] NULL
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[film_sales_S2] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[film_sales_S2](
	[RevenueID] [nvarchar](255) NOT NULL,
	[Film Name] [nvarchar](255) NULL,
	[Cinema ID] [nvarchar](255) NULL,
	[total_sales] [int] NULL,
	[Standard_Seats_sold] [int] NULL,
	[VIP_Seats_sold] [int] NULL,
	[Standard_Seats_out] [int] NULL,
	[VIP_Seats_out] [int] NULL,
	[occur_perc] [float] NULL,
	[ticket_use] [int] NULL,
	[year] [int] NULL,
	[quarter] [int] NULL,
	[month] [int] NULL,
	[day] [int] NULL,
) ON [PRIMARY]
GO

USE [master]
GO
ALTER DATABASE [BI07_STAGE] SET  READ_WRITE 
GO

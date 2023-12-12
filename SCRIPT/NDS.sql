USE [master]
GO
/****** Object:  Database [BI07_NDS]    Script Date: 08/12/23 1:10:35 SA ******/
CREATE DATABASE [BI07_NDS]
GO
USE [BI07_NDS]
GO

/****** Object:  Table [dbo].[product_line]    Script Date: 08/12/23 1:10:36 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_line](
	[ProductLineID_SK] [int] NOT NULL,
	[ProductLineID_NK] [nvarchar](255) NOT NULL,
	[Product line] [nvarchar](255) NULL,
	[createdDate] [datetime] NULL,
	[updatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductLineID_SK])
)
GO

/****** Object:  Table [dbo].[product]    Script Date: 12/12/2023 10:58:25 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[product](
	[ProductID_SK] [int] NOT NULL,
	[ProductID_NK] [nvarchar](255) NOT NULL,
	[Unit price] [float] NOT NULL,
	[ProductLineID_SK] [int] NULL,
	[createdDate] [datetime] NULL,
	[updatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[product]  WITH CHECK ADD  CONSTRAINT [FK_ProductLineID_SK] FOREIGN KEY([ProductLineID_SK])
REFERENCES [dbo].[product_line] ([ProductLineID_SK])
GO

ALTER TABLE [dbo].[product] CHECK CONSTRAINT [FK_ProductLineID_SK]
GO

/****** Object:  Table [dbo].[city]    Script Date: 12/12/2023 10:58:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[city](
	[Branch_SK] [int] NOT NULL,
	[Branch_NK] [nvarchar](255) NOT NULL,
	[City] [nvarchar](255) NULL,
	[createdDate] [datetime] NULL,
	[updatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Branch_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

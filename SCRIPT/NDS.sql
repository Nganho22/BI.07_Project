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

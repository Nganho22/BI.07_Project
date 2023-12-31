USE [master]
GO
CREATE DATABASE [BI07_NDS]
go
USE [BI07_NDS]
GO
/****** Object:  Table [dbo].[city]    Script Date: 18/12/23 12:39:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[city](
	[Branch_SK] [int] NOT NULL,
	[Branch_NK] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
	[createdDate] [datetime] NULL,
	[updatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Branch_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[customer_type]    Script Date: 18/12/23 12:39:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customer_type](
	[customer_typeID_SK] [int] NOT NULL,
	[Customer type] [nvarchar](255) NULL,
	[createdDate] [datetime] NULL,
	[updatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_typeID_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DATE_MASTER]    Script Date: 18/12/23 12:39:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DATE_MASTER](
	[DateKey] [varchar](8) NOT NULL,
	[Day] [int] NULL,
	[Month] [int] NULL,
	[Year] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payment]    Script Date: 18/12/23 12:39:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payment](
	[paymentID_SK] [int] NOT NULL,
	[Payment type] [nvarchar](255) NULL,
	[createdDate] [datetime] NULL,
	[updatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[paymentID_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product]    Script Date: 18/12/23 12:39:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product](
	[ProductID_SK] [int] NOT NULL,
	[ProductID_NK] [nvarchar](255) NULL,
	[Unit price] [float] NULL,
	[ProductLineID_SK] [int] NULL,
	[createdDate] [datetime] NULL,
	[updatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductID_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[product_line]    Script Date: 18/12/23 12:39:09 CH ******/
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
	[ProductLineID_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[supermarket_sales]    Script Date: 18/12/23 12:39:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[supermarket_sales](
	[Invoice ID_SK] [int] NOT NULL,
	[Invoice ID_NK] [nvarchar](255) NULL,
	[Branch_SK] [int] NULL,
	[customer_typeID_SK] [int] NULL,
	[Gender] [int] NULL,
	[ProductID_SK] [int] NULL,
	[Quantity] [int] NULL,
	[Tax 5%] [float] NULL,
	[Total] [float] NULL,
	[DateKey] [varchar](8) NULL,
	[TimeKey] [varchar](4) NULL,
	[paymentID_SK] [int] NULL,
	[cogs] [float] NULL,
	[gross margin percentage] [float] NULL,
	[gross income] [float] NULL,
	[Rating] [float] NULL,
	[SOURCE_ID] [int] NOT NULL,
	[createdDate] [datetime] NULL,
	[updatedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Invoice ID_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TIME_MASTER]    Script Date: 18/12/23 12:39:09 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TIME_MASTER](
	[TimeKey] [varchar](4) NOT NULL,
	[Hour] [int] NULL,
	[Minute] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[TimeKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[product]  WITH CHECK ADD FOREIGN KEY([ProductLineID_SK])
REFERENCES [dbo].[product_line] ([ProductLineID_SK])
GO
ALTER TABLE [dbo].[supermarket_sales]  WITH CHECK ADD FOREIGN KEY([Branch_SK])
REFERENCES [dbo].[city] ([Branch_SK])
GO
ALTER TABLE [dbo].[supermarket_sales]  WITH CHECK ADD FOREIGN KEY([customer_typeID_SK])
REFERENCES [dbo].[customer_type] ([customer_typeID_SK])
GO
ALTER TABLE [dbo].[supermarket_sales]  WITH CHECK ADD FOREIGN KEY([DateKey])
REFERENCES [dbo].[DATE_MASTER] ([DateKey])
GO
ALTER TABLE [dbo].[supermarket_sales]  WITH CHECK ADD FOREIGN KEY([paymentID_SK])
REFERENCES [dbo].[payment] ([paymentID_SK])
GO
ALTER TABLE [dbo].[supermarket_sales]  WITH CHECK ADD FOREIGN KEY([ProductID_SK])
REFERENCES [dbo].[product] ([ProductID_SK])
GO
ALTER TABLE [dbo].[supermarket_sales]  WITH CHECK ADD FOREIGN KEY([TimeKey])
REFERENCES [dbo].[TIME_MASTER] ([TimeKey])
GO
USE [master]
GO
ALTER DATABASE [BI07_NDS] SET  READ_WRITE 
GO



INSERT INTO DATE_MASTER(DateKey)
SELECT TOP (DATEDIFF(DAY, '2019-01-01', '2019-03-31') + 1)
    CONVERT(VARCHAR(8), DATEADD(DAY, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1, '2019-01-01'), 112) AS DateKey
FROM master.dbo.spt_values;


update DATE_MASTER
set Day = convert(int, SUBSTRING(DateKey, 7, 2)), Month = convert(int, SUBSTRING(DateKey, 5, 2)), Year = convert(int, SUBSTRING(DateKey, 1, 4));


declare @Hour INT = 0, @Minute INT = 0;

while @Hour <= 23
begin
    while @Minute <= 59
    begin
        insert into TIME_MASTER (TimeKey, Hour, Minute)
        values (
            RIGHT('00' + CAST(@Hour AS VARCHAR(2)), 2) + RIGHT('00' + CAST(@Minute AS VARCHAR(2)), 2),
            @Hour,
            @Minute
        );

        set @Minute = @Minute + 1;
    end

    set @Minute = 0;
    set @Hour = @Hour + 1;
end;


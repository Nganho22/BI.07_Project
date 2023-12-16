CREATE DATABASE BI07_DDS
USE BI07_DDS
GO

/****** Object:  Table [dbo].[DATE_MASTER]    Script Date: 12/13/2023 5:07:26 PM ******/
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

/****** Object:  Table [dbo].[TIME_MASTER]    Script Date: 12/13/2023 5:08:45 PM ******/
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


/****** Object:  Table [dbo].[payment]    Script Date: 12/13/2023 5:10:22 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[payment](
	[paymentID_SK] [int] NOT NULL,
	[Payment type] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[paymentID_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- drop TABLE payment_Audit
--CREATE TABLE payment_Audit (
--	id INT IDENTITY(1,1) PRIMARY KEY,
--    [paymentID_SK] int,
--    [Payment type_old_values] nvarchar(255),
--	updatedDate datetime null,
--	FOREIGN KEY ([paymentID_SK]) REFERENCES payment([paymentID_SK])
--)

/****** Object:  Table [dbo].[city]    Script Date: 12/13/2023 5:10:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[city](
	[Branch_SK] [int] NOT NULL,
	[Branch] [nvarchar](255) NULL,
	[City] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[Branch_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE city_Audit (
	id INT IDENTITY(1,1) PRIMARY KEY,
    [Branch_SK] int,
	[Branch_old_values] [nvarchar](255) NULL,
    [City_old_values] nvarchar(255),
	updatedDate datetime null,
	FOREIGN KEY ([Branch_SK]) REFERENCES City([Branch_SK])
)


/****** Object:  Table [dbo].[product_line]    Script Date: 12/13/2023 5:34:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[product_line](
	[ProductLineID_SK] [int] NOT NULL,
	[Product line] [nvarchar](255) NULL
PRIMARY KEY CLUSTERED 
(
	[ProductLineID_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE product_line_Audit (
	id INT IDENTITY(1,1) PRIMARY KEY,
    [ProductLineID_SK] int,
    [Product line_old_values] nvarchar(255),
	updatedDate datetime null,
	FOREIGN KEY ([ProductLineID_SK]) REFERENCES product_line([ProductLineID_SK])
)

/****** Object:  Table [dbo].[product]    Script Date: 12/13/2023 5:35:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[product](
	[ProductID_SK] [int] NOT NULL,
	[Unit price] [float] NULL
PRIMARY KEY CLUSTERED 
(
	[ProductID_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

CREATE TABLE product_Audit (
	id INT IDENTITY(1,1) PRIMARY KEY,
    [ProductID_SK] int,
    [Unit price_old_values] float,
	updatedDate datetime null,
	FOREIGN KEY ([ProductID_SK]) REFERENCES product([ProductID_SK])
)

/****** Object:  Table [dbo].[customer_type]    Script Date: 12/13/2023 5:36:12 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[customer_type](
	[customer_typeID_SK] [int] NOT NULL,
	[Customer type] [nvarchar](255) NULL
PRIMARY KEY CLUSTERED 
(
	[customer_typeID_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

-- drop TABLE customer_type_Audit
--CREATE TABLE customer_type_Audit (
--	id INT IDENTITY(1,1) PRIMARY KEY,
--    [customer_typeID_SK] int,
--    [Customer type_old_values] nvarchar(255),
--	updatedDate datetime null,
--	FOREIGN KEY ([customer_typeID_SK]) REFERENCES customer_type([customer_typeID_SK])
--)

CREATE TABLE [supermarket_sales] (
    [Invoice ID_SK] int NOT NULL,
    [Branch_SK] int,
    [customer_typeID_SK] int,
    [Gender] varchar(10),
    [ProductID_SK] int,
	[ProductLineID_SK] int,
    [Quantity] int,
    [Tax 5%] float,
    [Total] float,
    [DateKey] varchar(8),
    [TimeKey] varchar(4),
    [paymentID_SK] int,
    [cogs] float,
    [gross margin percentage] float,
    [gross income] float,
    [Rating] float,
    PRIMARY KEY ([Invoice ID_SK]),
    FOREIGN KEY (Branch_SK) REFERENCES city(Branch_SK),
    FOREIGN KEY (customer_typeID_SK) REFERENCES customer_type(customer_typeID_SK),
    FOREIGN KEY (ProductID_SK) REFERENCES product(ProductID_SK),
	FOREIGN KEY (ProductLineID_SK) REFERENCES product_line(ProductLineID_SK),
    FOREIGN KEY (DateKey) REFERENCES DATE_MASTER(DateKey),
    FOREIGN KEY (TimeKey) REFERENCES TIME_MASTER(TimeKey),
    FOREIGN KEY (paymentID_SK) REFERENCES payment(paymentID_SK)
)

CREATE TABLE [supermarket_sales_audit] (
    [Invoice ID_SK] int NOT NULL,
    [Branch_SK_old_values] int,
    [customer_typeID_SK_old_values] int,
    [Gender_old_values] varchar(10),
    [ProductID_SK_old_values] int,
	[ProductLineID_SK_old_values] int,
    [Quantity_old_values] int,
    [Tax 5%_old_values] float,
    [Total_old_values] float,
    [DateKey_old_values] varchar(8),
    [TimeKey_old_values] varchar(4),
    [paymentID_SK_old_values] int,
    [cogs_old_values] float,
    [gross margin percentage_old_values] float,
    [gross income_old_values] float,
    [Rating_old_values] float,
	updatedDate datetime null,
	FOREIGN KEY ([Invoice ID_SK]) REFERENCES supermarket_sales([Invoice ID_SK])
)


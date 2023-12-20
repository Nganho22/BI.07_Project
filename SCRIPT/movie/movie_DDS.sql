USE [master]
GO


CREATE DATABASE [BI07_MOVIE_DDS]
GO
USE [BI07_MOVIE_DDS]
GO

CREATE TABLE [dbo].[film](
	[FilmID_SK] [int] NOT NULL,
	[Film Name] [nvarchar](255) NULL,
	[Price] [int] NULL
PRIMARY KEY CLUSTERED 
(
	[FilmID_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[film_cate] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[film_cate](
	[FilmCategoryID_SK] [int] NOT NULL,
	[Film Category] [nvarchar](255) NULL
PRIMARY KEY CLUSTERED 
(
	[FilmCategoryID_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[cinema] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cinema](
	[CinemaID_SK] [int] NOT NULL,
	[Cinema Name] [nvarchar](255) NULL,
	[Capacity] [int] NULL,
	[Standard_Seats_price] [int] NULL,
	[VIP_Seats_price] [int] NULL
PRIMARY KEY CLUSTERED 
(
	[CinemaID_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[city] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[city](
	[CityID_SK] [int] NOT NULL,
	[City Name] [nvarchar](255) NULL
PRIMARY KEY CLUSTERED 
(
	[CityID_SK] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[DATE_MASTER] ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[DATE_MASTER](
	[DateKey] [varchar](8) NOT NULL,
	[Day] [int] NULL,
	[Month] [int] NULL,
	[Year] [int] NULL,
	[Quarter] [int] NULL
PRIMARY KEY CLUSTERED 
(
	[DateKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

INSERT INTO DATE_MASTER(DateKey)
SELECT TOP (DATEDIFF(DAY, '2018-03-01', '2018-10-31') + 1)
    CONVERT(VARCHAR(8), DATEADD(DAY, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1, '2018-03-01'), 112) AS DateKey
FROM master.dbo.spt_values;


update DATE_MASTER
set Day = convert(int, SUBSTRING(DateKey, 7, 2)), Month = convert(int, SUBSTRING(DateKey, 5, 2)), Year = convert(int, SUBSTRING(DateKey, 1, 4));

update DATE_MASTER
set Quarter = 1
where Month = 1  or Month = 2  or Month = 3

update DATE_MASTER
set Quarter = 2
where Month = 4  or Month = 5  or Month = 6

update DATE_MASTER
set Quarter = 3
where Month = 7  or Month = 8  or Month = 9

update DATE_MASTER
set Quarter = 4
where Month = 10  or Month = 11  or Month = 12



/****** Object:  Table [dbo].[film_sales] ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[film_sales](
	[RevenueID_SK] [int] NOT NULL,
	[FilmID_SK] [int] NULL,
	[FilmCategoryID_SK] [int] NULL,
	[CinemaID_SK] [int] NULL,
	[CityID_SK] [int] NULL,
	[total_sales] [int] NULL,
	[tickets_sold] [int] NULL,
	[Standard_Seats_sold] [int] NULL,
	[VIP_Seats_sold] [int] NULL,
	[tickets_out] [int] NULL,
	[Standard_Seats_out] [int] NULL,
	[VIP_Seats_out] [int] NULL,
	[ticket_use] [int] NULL,
	[occur_perc] [float] NULL,
	[DateKey] [varchar](8) NULL,
	[SOURCE_ID] [int] NOT NULL
    PRIMARY KEY ([RevenueID_SK]),
    FOREIGN KEY ([FilmID_SK]) REFERENCES film([FilmID_SK]),
    FOREIGN KEY ([FilmCategoryID_SK]) REFERENCES [film_cate]([FilmCategoryID_SK]),
    FOREIGN KEY ([CinemaID_SK]) REFERENCES [cinema]([CinemaID_SK]),
	FOREIGN KEY ([CityID_SK]) REFERENCES [city]([CityID_SK]),
    FOREIGN KEY ([DateKey]) REFERENCES [DATE_MASTER]([DateKey])
)




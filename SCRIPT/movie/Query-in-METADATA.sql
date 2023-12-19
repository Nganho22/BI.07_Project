USE MASTER
CREATE DATABASE BI07_MOVIE_METADATA
GO
USE BI07_MOVIE_METADATA
GO


CREATE TABLE [dbo].[DATA_FLOW](
	[ID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[SOURCE_NAME] [varchar](30) NULL,
	[LSET] [datetime] NULL,
	[CET] [datetime] NULL
)
GO


-- DATA STORE INFO
CREATE TABLE DATA_STORE_INFO
(
	DBS_ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	DBS_NAME varchar(255) NOT NULL,
	DESCRIPTIONS VARCHAR(255) NULL
)

INSERT INTO DATA_STORE_INFO VALUES('BI07_MOVIE_METADATA', 'Describes whole data information in system');
INSERT INTO DATA_STORE_INFO VALUES ('BI07_MOVIE_STAGE','An internal data store used for transforming and preparing the data obtained from the source systems, before being loaded to other data stores in DW')
INSERT INTO DATA_STORE_INFO VALUES ('BI07_MOVIE_NDS','An internal master data store in the form of normalized relational databases used for integrating data from various source systems captured in Stage database')
INSERT INTO DATA_STORE_INFO VALUES ('BI07_MOVIE_DDS','A user-facing data store, in the form of relational databases used for supporting analytical queries')

-- DATA TABLE INFO
CREATE TABLE DATA_TABLE_INFO
(
	TABLE_ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	DBS_ID int not NULL,
	TABLE_NAME varchar(255) NOT NULL,
	TABLE_TYPE VARCHAR(50),
	DESCRIPTIONS VARCHAR(255) NULL,
	UPDATEDATE DATETIME NULL,
	FOREIGN KEY (DBS_ID) REFERENCES DATA_STORE_INFO (DBS_ID)
)

--drop table [DATA_FLOW]
-- drop table COLUMN_INFO
-- drop table DATA_TABLE_INFO
--drop table DATA_STORE_INFO

--select* from DATA_TABLE_INFO

--METADATA
INSERT INTO DATA_TABLE_INFO VALUES (1, 'DATA_FLOW','METADATA','Store the timestamps of data source flow that ETL to DW', NULL);
INSERT INTO DATA_TABLE_INFO VALUES (1, 'DATA_TABLE_INFO','METADATA','Store table information', getdate());
INSERT INTO DATA_TABLE_INFO VALUES (1, 'DATA_STORE_INFO','METADATA','Store database information', getdate());

-- STAGE
INSERT INTO DATA_TABLE_INFO VALUES (2, 'film','Stage','Store film data from source', NULL);
INSERT INTO DATA_TABLE_INFO VALUES (2, 'film_category','Stage','Store film category data from source', NULL);
INSERT INTO DATA_TABLE_INFO VALUES (2, 'cinema','Stage','Store Cinema data about the city from source', NULL)
INSERT INTO DATA_TABLE_INFO VALUES (2, 'city','Stage','Store City data from source', NULL)
INSERT INTO DATA_TABLE_INFO VALUES (2, 'film_sales_S1','Stage','Store film_sales_S1 data from source', NULL)
INSERT INTO DATA_TABLE_INFO VALUES (2, 'film_sales_S2','Stage','Store Ho Chi Minh city film sales data from source', NULL);

-- NDS
INSERT INTO DATA_TABLE_INFO VALUES (3, 'DATE_MASTER','NDS','Store date data from source', NULL);
INSERT INTO DATA_TABLE_INFO VALUES (3, 'film','Master tables(NDS)','Store film data', NULL)
INSERT INTO DATA_TABLE_INFO VALUES (3, 'film_cate','Master tables(NDS)', 'Store film category data', NULL)
INSERT INTO DATA_TABLE_INFO VALUES (3,'city', 'Master tables(NDS)','Store city data', NULL)
INSERT INTO DATA_TABLE_INFO VALUES (3,'cinema', 'Master tables(NDS)','Store cinema data', NULL)
INSERT INTO DATA_TABLE_INFO VALUES (3, 'film_sales','NDS','Store film sale data from source', NULL);

-- DDS
INSERT INTO DATA_TABLE_INFO VALUES (4, 'film','dimension','Store film Dimension', NULL)
INSERT INTO DATA_TABLE_INFO VALUES (4, 'film_cate','dimension','Store film category Dimension', NULL)
INSERT INTO DATA_TABLE_INFO VALUES (4, 'city','dimension','Store city Dimension', NULL)
INSERT INTO DATA_TABLE_INFO VALUES (4, 'cinema','dimension','Store cinema Dimension', NULL)
INSERT INTO DATA_TABLE_INFO VALUES (4, 'film_sales','fact','Store film sale fact', NULL);

--COLUMN_INFO
create table COLUMN_INFO
(
	COLUMN_ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	TABLE_ID int NOT NULL,
	COLUMN_NAME varchar(255) NOT NULL,
	COLUMN_TYPE VARCHAR(50),
	DESCRIPTIONS VARCHAR(255) NULL,
	SAMPLE_VALUES varchar(50),
	SOURCE_COLUMN_KEY_ID INT NULL,
	FOREIGN KEY (TABLE_ID) REFERENCES DATA_TABLE_INFO(TABLE_ID),
	    FOREIGN KEY (SOURCE_COLUMN_KEY_ID) REFERENCES COLUMN_INFO(COLUMN_ID)

)

-- FILM STAGE
INSERT INTO COLUMN_INFO VALUES (4, N'FilmID','nvarchar','store film ID','F7',NULL)
INSERT INTO COLUMN_INFO VALUES (4, N'Film Name','nvarchar','store film name','Wonka',NULL) 
INSERT INTO COLUMN_INFO VALUES (4, N'FilmCategoryID','nvarchar','store film category ID', N'FC1','1')
INSERT INTO COLUMN_INFO VALUES (4, N'Price','int','store film price','25000',NULL)

-- FILM_CATE STAGE
INSERT INTO COLUMN_INFO VALUES (5, N'FilmCategoryID',N'nvarchar','store Film Category Key', N'FC1',NULL)
INSERT INTO COLUMN_INFO VALUES (5, N'Film Category',N'nvarchar','store Film Category', N'Action',NULL)

-- CINEMA STAGE
INSERT INTO COLUMN_INFO VALUES (6, N'CinemaID', N'nvarchar','store Cinema Key','C1',NULL)
INSERT INTO COLUMN_INFO VALUES (6, N'Cinema Name', N'nvarchar','store Cinema Name','Galaxy Cinema',NULL)
INSERT INTO COLUMN_INFO VALUES (6, N'CityID', N'nvarchar','store City Key','HCM',NULL)
INSERT INTO COLUMN_INFO VALUES (6, N'Capacity', N'int','store Capacity', '1800', NULL)
INSERT INTO COLUMN_INFO VALUES (6, N'Standard_Seats_price', N'int','store Standard Seats Price','30000', NULL)
INSERT INTO COLUMN_INFO VALUES (6, N'VIP_Seats_price', N'int','store VIP Seats Price', '50000', NULL)

-- CITY STAGE
INSERT INTO COLUMN_INFO VALUES (7, N'CityID', N'nvarchar','store City Key','HCM',NULL)
INSERT INTO COLUMN_INFO VALUES (7, N'CityName',N'nvarchar','store City Name', N'Ho Chi Minh',NULL)

-- film_sales_S1
INSERT INTO COLUMN_INFO VALUES (8, N'RevenueID','nvarchar','store revenue ID','RV1',NULL)
INSERT INTO COLUMN_INFO VALUES (8, N'FilmID','nvarchar','store film ID','F2',NULL)
INSERT INTO COLUMN_INFO VALUES (8, N'Cinema Name','nvarchar','store cinema name','Mega Cinema',NULL) 
INSERT INTO COLUMN_INFO VALUES (8, N'total_sales','int','store total sale of revenue','4160000',NULL) 
INSERT INTO COLUMN_INFO VALUES (8, N'tickets_sold','int','store number of ticket sold','208',NULL) 
INSERT INTO COLUMN_INFO VALUES (8, N'Standard_Seats_sold','int','store number of standard seat sold','101',NULL) 
INSERT INTO COLUMN_INFO VALUES (8, N'VIP_Seats_sold','int','store number of VIP seat sold','107',NULL) 
INSERT INTO COLUMN_INFO VALUES (8, N'Standard_Seats_out','int','store number of standard seat cancelled','0',NULL) 
INSERT INTO COLUMN_INFO VALUES (8, N'VIP_Seats_out','int','store number of VIP seat cancelled','0',NULL) 
INSERT INTO COLUMN_INFO VALUES (8, N'tickets_out','int','store number of ticket cancelled','0',NULL) 
INSERT INTO COLUMN_INFO VALUES (8, N'occur_perc','float','store occupation percentage','16.00',NULL) 
INSERT INTO COLUMN_INFO VALUES (8, N'ticket_use','int','store number of ticket used','208',NULL) 
INSERT INTO COLUMN_INFO VALUES (8, N'date','date','store date data ','9/18/2018',NULL) 

-- film_sales_S2
INSERT INTO COLUMN_INFO VALUES (9, N'RevenueID','nvarchar','store revenue ID','RV1',NULL)
INSERT INTO COLUMN_INFO VALUES (9, N'Film Name','nvarchar','store film name','Avenger: Endgame',NULL)
INSERT INTO COLUMN_INFO VALUES (9, N'Cinema ID','nvarchar','store cinema ID','C1',NULL) 
INSERT INTO COLUMN_INFO VALUES (9, N'total_sales','int','store total sale of revenue','4160000',NULL) 
INSERT INTO COLUMN_INFO VALUES (9, N'Standard_Seats_sold','int','store number of standard seat sold','517',NULL) 
INSERT INTO COLUMN_INFO VALUES (9, N'VIP_Seats_sold','int','store number of VIP seat sold','648',NULL) 
INSERT INTO COLUMN_INFO VALUES (9, N'Standard_Seats_out','int','store number of standard seat cancelled','2',NULL) 
INSERT INTO COLUMN_INFO VALUES (9, N'VIP_Seats_out','int','store number of VIP seat cancelled','2',NULL) 
INSERT INTO COLUMN_INFO VALUES (9, N'occur_perc','float','store occupation percentage','64.5',NULL) 
INSERT INTO COLUMN_INFO VALUES (9, N'ticket_use','int','store number of ticket used','1161',NULL) 
INSERT INTO COLUMN_INFO VALUES (9, N'year','int','store year data','2018',NULL) 
INSERT INTO COLUMN_INFO VALUES (9, N'quarter','int','store quarter data','2',NULL) 
INSERT INTO COLUMN_INFO VALUES (9, N'month','int','store month data','5',NULL) 
INSERT INTO COLUMN_INFO VALUES (9, N'day','int','store day data','5',NULL) 

-- NDS

-- tu column_ID 42 trở đến 89
-- DATE_MASTER
INSERT INTO COLUMN_INFO VALUES (10, N'DateKey','nvarchar','Store date key','20190105',null)
INSERT INTO COLUMN_INFO VALUES (10, N'Day','int','Store day in date','05',null)
INSERT INTO COLUMN_INFO VALUES (10, N'Month','int','Store month in date','01',null)
INSERT INTO COLUMN_INFO VALUES (10, N'Year',N'int','Store year in date','2019',null)
INSERT INTO COLUMN_INFO VALUES (10, N'Quarter',N'int','Store quarter in date','2',null)

-- film_cate NDS
INSERT INTO COLUMN_INFO VALUES (12, N'FilmCategoryID_SK',N'int','store Film Category surrogate key', '1',NULL)
INSERT INTO COLUMN_INFO VALUES (12, N'Film Category ID_NK',N'nvarchar','store Film Category natural key', N'FC1',NULL)
INSERT INTO COLUMN_INFO VALUES (12, N'Film Category',N'nvarchar','store Film Category', N'Action',NULL)
INSERT INTO COLUMN_INFO VALUES (12, N'createdDate','datetime','Store created date',getdate(),null)
INSERT INTO COLUMN_INFO VALUES (12, N'updatedDate','datetime','Store uploaded date',getdate(),null)

--film NDS
INSERT INTO COLUMN_INFO VALUES (11, N'FilmID_SK','int','store film surrogate key','1',NULL)
INSERT INTO COLUMN_INFO VALUES (11, N'FilmID_NK','nvarchar','store film natural key','F7',NULL)
INSERT INTO COLUMN_INFO VALUES (11, N'Film Name','nvarchar','store film name','Wonka',NULL) 
INSERT INTO COLUMN_INFO VALUES (11, N'FilmCategoryID_SK','nvarchar','store film category surrogate key', '1', '47')
INSERT INTO COLUMN_INFO VALUES (11, N'Price','int','store film price','25000',NULL)
INSERT INTO COLUMN_INFO VALUES (11, N'createdDate','datetime','Store created date',getdate(),null)
INSERT INTO COLUMN_INFO VALUES (11, N'updatedDate','datetime','Store uploaded date',getdate(),null)

--city NDS
INSERT INTO COLUMN_INFO VALUES (13, N'CityID_SK', N'int','store City surrogate key','1',NULL)
INSERT INTO COLUMN_INFO VALUES (13, N'CityID_NK', N'nvarchar','store City natural key','HCM',NULL)
INSERT INTO COLUMN_INFO VALUES (13, N'CityName',N'nvarchar','store City Name', N'Ho Chi Minh',NULL)
INSERT INTO COLUMN_INFO VALUES (13, N'createdDate','datetime','Store created date',getdate(),null)
INSERT INTO COLUMN_INFO VALUES (13, N'updatedDate','datetime','Store uploaded date',getdate(),null)

--cinema NDS
INSERT INTO COLUMN_INFO VALUES (14, N'CinemaID_SK', N'int','store Cinema Key','C1',NULL)
INSERT INTO COLUMN_INFO VALUES (14, N'CinemaID_NK', N'nvarchar','store Cinema Key','C1',NULL)
INSERT INTO COLUMN_INFO VALUES (14, N'Cinema Name', N'nvarchar','store Cinema Name','Galaxy Cinema',NULL)
INSERT INTO COLUMN_INFO VALUES (14, N'CityID_SK', N'nvarchar','store City Key','1','59')
INSERT INTO COLUMN_INFO VALUES (14, N'Capacity', N'int','store Capacity', '1800', NULL)
INSERT INTO COLUMN_INFO VALUES (14, N'Standard_Seats_price', N'int','store Standard Seats Price','30000', NULL)
INSERT INTO COLUMN_INFO VALUES (14, N'VIP_Seats_price', N'int','store VIP Seats Price', '50000', NULL)
INSERT INTO COLUMN_INFO VALUES (14, N'createdDate','datetime','Store created date',getdate(),null)
INSERT INTO COLUMN_INFO VALUES (14, N'updatedDate','datetime','Store uploaded date',getdate(),null)

-- FILM_SALES NDS
INSERT INTO COLUMN_INFO VALUES (15, N'RevenueID_SK','int','Store revenue ID surrogate key','1',null)
INSERT INTO COLUMN_INFO VALUES (15, N'RevenueID_NK','nvarchar','Store revenue ID natural key','RV1',null)
INSERT INTO COLUMN_INFO VALUES (15, N'FilmID_SK','int','Store film ID surrogate key','1','52')
INSERT INTO COLUMN_INFO VALUES (15, N'CinemaID_SK','int','Store Cinema ID surrogate key','1', '64')
INSERT INTO COLUMN_INFO VALUES (15, N'total_sales','int','store total sale of revenue','4160000',NULL) 
INSERT INTO COLUMN_INFO VALUES (15, N'tickets_sold','int','store number of ticket sold','208',NULL) 
INSERT INTO COLUMN_INFO VALUES (15, N'Standard_Seats_sold','int','store number of standard seat sold','517',NULL) 
INSERT INTO COLUMN_INFO VALUES (15, N'VIP_Seats_sold','int','store number of VIP seat sold','648',NULL) 
INSERT INTO COLUMN_INFO VALUES (15, N'tickets_out','int','store number of ticket cancelled','0',NULL) 
INSERT INTO COLUMN_INFO VALUES (15, N'Standard_Seats_out','int','store number of standard seat cancelled','0',NULL) 
INSERT INTO COLUMN_INFO VALUES (15, N'VIP_Seats_out','int','store number of VIP seat out','0',NULL) 
INSERT INTO COLUMN_INFO VALUES (15, N'ticket_use','int','store number of ticket used','1161',NULL) 
INSERT INTO COLUMN_INFO VALUES (15, N'occur_perc','float','store occupation percentage','64.5',NULL) 
INSERT INTO COLUMN_INFO VALUES (15, N'DateKey','nvarchar','Store date key','20190105','42')
INSERT INTO COLUMN_INFO VALUES (15, N'SOURCE_ID','int','Store source key','1',null)
INSERT INTO COLUMN_INFO VALUES (15, N'createdDate','datetime','Store created date','2023-12-17 01:45:43.000',null)
INSERT INTO COLUMN_INFO VALUES (15, N'updatedDate','datetime','Store uploaded date','2023-12-17 01:45:43.000',null)

-- DDS

-- tu column_ID 90 đến 106

-- DATE_MASTER DDS
INSERT INTO COLUMN_INFO VALUES (16, N'DateKey','nvarchar','Store date key','20190105',null)
INSERT INTO COLUMN_INFO VALUES (16, N'Day','int','Store day in date','05',null)
INSERT INTO COLUMN_INFO VALUES (16, N'Month','int','Store month in date','01',null)
INSERT INTO COLUMN_INFO VALUES (16, N'Year',N'int','Store year in date','2019',null)
INSERT INTO COLUMN_INFO VALUES (16, N'Quarter',N'int','Store quarter in date','2',null)

--film DDS
INSERT INTO COLUMN_INFO VALUES (17, N'FilmID_SK','int','store film surrogate key','1',NULL)
INSERT INTO COLUMN_INFO VALUES (17, N'Film Name','nvarchar','store film name','Wonka',NULL) 
INSERT INTO COLUMN_INFO VALUES (17, N'Price','int','store film price','25000',NULL)

-- film_cate DDS
INSERT INTO COLUMN_INFO VALUES (18, N'FilmCategoryID_SK',N'int','store Film Category surrogate key', '1',NULL)
INSERT INTO COLUMN_INFO VALUES (18, N'Film Category',N'nvarchar','store Film Category', N'Action',NULL)

--city DDS
INSERT INTO COLUMN_INFO VALUES (19, N'CityID_SK', N'int','store City surrogate key','1',NULL)
INSERT INTO COLUMN_INFO VALUES (19, N'CityName',N'nvarchar','store City Name', N'Ho Chi Minh',NULL)

--cinema DDS
INSERT INTO COLUMN_INFO VALUES (20, N'CinemaID_SK', N'int','store Cinema Key','C1',NULL)
INSERT INTO COLUMN_INFO VALUES (20, N'Cinema Name', N'nvarchar','store Cinema Name','Galaxy Cinema',NULL)
INSERT INTO COLUMN_INFO VALUES (20, N'Capacity', N'int','store Capacity', '1800', NULL)
INSERT INTO COLUMN_INFO VALUES (20, N'Standard_Seats_price', N'int','store Standard Seats Price','30000', NULL)
INSERT INTO COLUMN_INFO VALUES (20, N'VIP_Seats_price', N'int','store VIP Seats Price', '50000', NULL)



-- FILM_SALES DDS
INSERT INTO COLUMN_INFO VALUES (21, N'RevenueID_SK','int','Store revenue ID surrogate key','1',null)
INSERT INTO COLUMN_INFO VALUES (21, N'FilmID_SK','int','Store film ID surrogate key','1','95')
INSERT INTO COLUMN_INFO VALUES (21, N'FilmCategoryID_SK',N'int','store Film Category surrogate key', '1', '98')
INSERT INTO COLUMN_INFO VALUES (21, N'CinemaID_SK','int','Store Cinema ID surrogate key','1','102')
INSERT INTO COLUMN_INFO VALUES (21, N'CityID_SK', N'int','store City surrogate key','1','100')
INSERT INTO COLUMN_INFO VALUES (21, N'total_sales','int','store total sale of revenue','4160000',NULL) 
INSERT INTO COLUMN_INFO VALUES (21, N'tickets_sold','int','store number of ticket sold','208',NULL) 
INSERT INTO COLUMN_INFO VALUES (21, N'Standard_Seats_sold','int','store number of standard seat sold','517',NULL) 
INSERT INTO COLUMN_INFO VALUES (21, N'VIP_Seats_sold','int','store number of VIP seat sold','648',NULL) 
INSERT INTO COLUMN_INFO VALUES (21, N'tickets_out','int','store number of ticket cancelled','0',NULL) 
INSERT INTO COLUMN_INFO VALUES (21, N'Standard_Seats_out','int','store number of standard seat cancelled','0',NULL) 
INSERT INTO COLUMN_INFO VALUES (21, N'VIP_Seats_out','int','store number of VIP seat out','3',NULL) 
INSERT INTO COLUMN_INFO VALUES (21, N'ticket_use','int','store number of ticket used','1161',NULL) 
INSERT INTO COLUMN_INFO VALUES (21, N'occur_perc','float','store occupation percentage','64.5',NULL) 
INSERT INTO COLUMN_INFO VALUES (21, N'DateKey','nvarchar','Store date key','20190105','90')
INSERT INTO COLUMN_INFO VALUES (21, N'SOURCE_ID','int','Store source key','1',null)

select * from data_table_info
select * from COLUMN_INFO
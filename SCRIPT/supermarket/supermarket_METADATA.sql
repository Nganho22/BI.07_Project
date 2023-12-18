

USE master
GO
CREATE DATABASE BI07_METATDA
GO
USE BI07_METADATA
CREATE TABLE [dbo].[DATA_FLOW](
	[ID] [int] IDENTITY(1,1) PRIMARY KEY NOT NULL,
	[SOURCE_NAME] [varchar](30) NULL,
	[LSET] [datetime] NULL,
	[CET] [datetime] NULL
)
GO

--DATA_STORE_INFO
CREATE TABLE DATA_STORE_INFO
(
	DBS_ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	DBS_NAME varchar(255) NOT NULL,
	DESCRIPTIONS VARCHAR(255) NULL
)

CREATE TABLE DATA_TABLE_INFO
(
	TABLE_ID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	DBS_ID int not NULL,
	TABLE_NAME varchar(255) NOT NULL,
	TABLE_TYPE VARCHAR(50),
	DESCRIPTIONS VARCHAR(255) NULL,
	UPDATEDATE DATETIME NULL,
	FOREIGN KEY (DBS_ID) REFERENCES DATA_STORE_INFO(DBS_ID)
)

INSERT INTO DATA_STORE_INFO VALUES('BI07_METADATA', 'Describes whole data information in system');
INSERT INTO DATA_STORE_INFO VALUES ('BI07_STAGE','An internal data store used for transforming and preparing the data obtained from the source systems, before being loaded to other data stores in DW')
INSERT INTO DATA_STORE_INFO VALUES ('BI07_NDS','An internal master data store in the form of normalized relational databases used for integrating data from various source systems captured in Stage database')
INSERT INTO DATA_STORE_INFO VALUES ('BI07_DDS','A user-facing data store, in the form of relational databases used for supporting analytical queries')

--METADATA
INSERT INTO DATA_TABLE_INFO VALUES (1, 'DATA_FLOW','METADATA','Store the timestamps of data source flow that ETL to DW', NULL);

--Stage
INSERT INTO DATA_TABLE_INFO VALUES (2, 'city','Stage','Store City data about the city from source', NULL)
insert into DATA_TABLE_INFO VALUES (2,'product_line','Stage','Store Product Line data from source', NULL)
INSERT INTO DATA_TABLE_INFO VALUES (2,'product','Stage','Store Product data from source', NULL)
INSERT INTO DATA_TABLE_INFO VALUES(2, 'supermarket_sales','Stage','Store the Invoice data of supermarket_sales from source', NULL)

--NDS
INSERT INTO DATA_TABLE_INFO VALUES(3,'DATE','Master tables(NDS)', 'Store date data', GETDATE())
INSERT INTO DATA_TABLE_INFO VALUES(3, 'TIME','Master tables(NDS)', 'Store time data', GETDATE())
INSERT INTO DATA_TABLE_INFO VALUES(3, 'payment','Master tables(NDS)','Store payment type', NULL)
INSERT INTO DATA_TABLE_INFO VALUES(3, 'city','Master tables(NDS)', 'Store city data', NULL)
INSERT INTO DATA_TABLE_INFO VALUES(3,'customer_type', 'Master tables(NDS)','Store customer type', NULL)
INSERT INTO DATA_TABLE_INFO VALUES (3,'product_line', 'Master tables(NDS)','Store product line data', NULL)
INSERT INTO DATA_TABLE_INFO VALUES(3, 'product','Master tables(NDS)','Store product info data', NULL)
INSERT INTO DATA_TABLE_INFO VALUES(3,'supermarket_sales','Transaction table(NDS)', 'Store the invoice data of supermarket_sales', NULL)

-- DDS

INSERT INTO DATA_TABLE_INFO VALUES(4, 'TIME_MASTER','dimension','Store Time Dimension', GETDATE())

INSERT INTO DATA_TABLE_INFO VALUES(4, 'DATE_MASTER','dimension','Store Date Dimension', GETDATE())

INSERT INTO DATA_TABLE_INFO VALUES(4, 'payment','dimension','Store payment Dimension', NULL)

INSERT INTO DATA_TABLE_INFO VALUES(4, 'city','dimension','Store city Dimension', NULL)

INSERT INTO DATA_TABLE_INFO VALUES(4, 'product_line','dimension','Store product_line Dimension', NULL)

INSERT INTO DATA_TABLE_INFO VALUES(4, 'product','dimension','Store product Dimension', NULL)

INSERT INTO DATA_TABLE_INFO VALUES(4, 'customer_type','dimension','Store customer Dimension', NULL)

INSERT INTO DATA_TABLE_INFO VALUES(4, 'supermarket_sales','fact','Store supermarket_sales fact', NULL)



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
-- CITY STAGE
INSERT INTO COLUMN_INFO VALUES (2, N'Branch', N'nvarchar','store branch name','A',NULL)
INSERT INTO COLUMN_INFO VALUES (2, N'City',N'nvarchar','store city name', N'Yangon',NULL)

--PRODUCT LINE STAGE
INSERT INTO COLUMN_INFO VALUES(3,N'Product line',N'nvarchar','store product line','Health and beauty',NULL)
INSERT INTO COLUMN_INFO VALUES(3,N'ProductLineID',N'nvarchar','store product line key','PD001',NULL)

--PRODUCT STAGE
INSERT INTO COLUMN_INFO VALUES(4,N'ProductID', N'nvarchar','store product key','PID01',NULL)
INSERT INTO COLUMN_INFO VALUES(4, N'Unit price',N'float','store unit price','74,69',NULL)
INSERT INTO COLUMN_INFO VALUES(5, N'ProductLine',N'nvarchar','store productLine','PD001',null)

--supermarket_sales STAGE
insert into COLUMN_INFO values(5, N'Invoice ID',N'nvarchar','store invoice key','750-67-8428',null)
insert into COLUMN_INFO values(5, N'Branch',N'nvarchar','store branch name',N'A',NULL)
Insert into COLUMN_INFO values(5,'Customer type','nvarchar','store customer type',N'Member',null)
insert into COLUMN_INFO values(5,'Gender',N'nvarchar','store gender','Female',null)
insert into COLUMN_INFO values(5,'ProductID','nvarchar','store product key','PID01',NULL)
INSERT INTO COLUMN_INFO VALUES(5,'Quantity','int','store quantity','1',null)
insert into COLUMN_INFO values(5,'Tax 5%','float','store tax 5%','26,1415',null)
insert into COLUMN_INFO values(5,'Total','float','store total','548,9715',null)
insert into COLUMN_INFO values(5,'Date','Date','store date','2019-01-05',null)
insert into COLUMN_INFO values(5,'Time','Time','store time','13:08',null)
insert into COLUMN_INFO values(5,'Payment','nvarchar','store payment','Ewallet',null)
insert into COLUMN_INFO values(5,'cogs','float','store cogs','522,83',null)
insert into COLUMN_INFO values(5,'gross margin percentage','float','store gross margin percentage','4,761904762',null)
insert into COLUMN_INFO values(5,'gross income','float','store gross income','26,1415',null)
insert into COLUMN_INFO values(5,'Rating','float','store rating','9,1',null)


--DATE_MASTER NDS
insert into COLUMN_INFO values(6,N'DateKey',N'varchar','Store date key','20190105',null)
insert into COLUMN_INFO values(6,N'Day',N'int','Store day in date','05',null)
insert into COLUMN_INFO values(6,N'Month',N'int','Store month in date','01',null)
insert into COLUMN_INFO values(6,N'Year',N'int','Store year in dete','2019',null)

--TIME_MASTER NDS
insert into COLUMN_INFO values(7,N'TimeKey',N'varchar','Store time key','2019',null)
insert into COLUMN_INFO values(7,N'Hour',N'int','Store hour in time','20',null)
insert into COLUMN_INFO values(7,N'Minute',N'int','Store minute in time','19',null)

--payment NDS
insert into COLUMN_INFO values(8,N'paymentID_SK',N'int','Store payment key','1',null)
insert into COLUMN_INFO values(8,N'Payment type',N'nvarchar','Store payment type','Ewallet',null)

--city NDS
insert into COLUMN_INFO values(9,N'Branch_SK',N'int','Store branch key','1',null)
insert into COLUMN_INFO values(9,N'Branch_NK',N'nvarchar','Store branch name','A',null)
insert into COLUMN_INFO values(9,N'City',N'nvarchar','Store city name','A',null)

--customer_type NDS
insert into COLUMN_INFO values(10,N'customer_typeID_SK',N'int','Store customer key','1',null)
insert into COLUMN_INFO values(10,N'Customer type',N'nvarchar','Store customer type','Member',null)

--product_line NDS
insert into COLUMN_INFO values(11,N'ProductLineID_SK',N'int','Store productline surrogate key','1',null)
insert into COLUMN_INFO values(11,N'ProductLineID_NK',N'nvarchar','Store productline nature key','PD001',null)
insert into COLUMN_INFO values(11,N'Product line',N'nvarchar','Store productline name','PD001',null)

--product NDS
insert into COLUMN_INFO values(12,N'ProductID_SK',N'int','Store product surrogate key','1',null)
insert into COLUMN_INFO values(12,N'ProductID_NK',N'nvarchar','Store productline nature key','PID01',null)
insert into COLUMN_INFO values(12,N'Unit price',N'float','Store unit price','74.69',null)
insert into COLUMN_INFO values(12,N'ProductLineID_SK',N'int','Store productline surrogate key','1',37)


-- supermarket_sales NDS
insert into COLUMN_INFO values(13, N'InvoiceID_SK','int','Store invoice ID surrogate key', '1',null)
insert into COLUMN_INFO values(13, N'Invoice ID_NK','nvarchar','Store invoice ID surrogate key','1',null)
insert into COLUMN_INFO values(13, N'Branch_SK','int','Store branch ID surrogate key','1',32)
insert into COLUMN_INFO values(13, N'customer_typeID_SK','int','Store cuustomer type ID surrogate key','1',35)
insert into COLUMN_INFO values(13, N'Gender','int','Store customer gender','1',null)
insert into COLUMN_INFO values(13, N'ProductID_SK','int','Store product ID surrogate key','1',40)
insert into COLUMN_INFO values(13, N'Quantity','int','Store product quantity','2',null)
insert into COLUMN_INFO values(13, N'Tax 5%','float','Store tax amount','26.1415',null)
insert into COLUMN_INFO values(13, N'Total','float','Store Total amouunt of invoice','548.9715',null)
insert into COLUMN_INFO values(13, N'DateKey','varchar','Store invoice create Date key','20231223',23)
insert into COLUMN_INFO values(13, N'TimeKey','varchar','Store invoice create Time key','2359',27)
insert into COLUMN_INFO values(13, N'paymentID_SK','int','Store payment ID surrogate key','1',30)
insert into COLUMN_INFO values(13, N'cogs','float','Store cost of goods sold','522.83',null)
insert into COLUMN_INFO values(13, N'gross margin percentage','float','Store gross margin percentage amount','4.761904762',null)
insert into COLUMN_INFO values(13, N'gross income','float','Store gross income amount','26.1415',null)
insert into COLUMN_INFO values(13, N'Rating','float','Store ratings statistics','9.1',null)

-- DDS

-- DATE_MASTER
insert into COLUMN_INFO values(15, N'DateKey',N'varchar','Store Date Key','20231230',null)
insert into COLUMN_INFO values(15, N'Day','int','Store day in Date',30,null)
insert into COLUMN_INFO values(15, N'Month','int','Store month in Date',12,null)
insert into COLUMN_INFO values(15, N'Year','int','Store year in Date',2023,null)

-- TIME_MASTER
insert into COLUMN_INFO values(14, N'TimeKey',N'varchar','Store Time Key','2359',null)
insert into COLUMN_INFO values(14, N'Hour','int','Store Hour in Time',23,null)
insert into COLUMN_INFO values(14, N'Minute','int','Store Minute in Time ',59,null)


-- payment
insert into COLUMN_INFO values(16, N'paymentID_SK','int','Store payment ID surrogate key',1,null)
insert into COLUMN_INFO values(16, N'Payment type',N'varchar','Store payment type','Credit Card',null)

-- city
insert into COLUMN_INFO values(17, N'Branch_SK','int','Store Branch surrogate key',1,null)
insert into COLUMN_INFO values(17, N'Branch_NK','int','Store Branch natural key',1,null)
insert into COLUMN_INFO values(17, N'City',N'varchar','Store City name','Yagoon',null)

-- customer_type
insert into COLUMN_INFO values(20, N'customer_typeID_SK','int','Store customer type surrogate key',1,null)
insert into COLUMN_INFO values(20, N'Customer type',N'varchar','Store customer type name','Member',null)


-- product_line
insert into COLUMN_INFO values(18, N'ProductLineID_SK','int','Store product_line surrogate key',1,null)
insert into COLUMN_INFO values(18, N'Product line',N'varchar','Store product_line name','Health and Beauty',null)

-- product
insert into COLUMN_INFO values(19, N'ProductID_SK','int','Store product surrogate key',1,null)
insert into COLUMN_INFO values(19, N'Unit price','float','Store price of product',74.69,null)

-- supermarket_sales
insert into COLUMN_INFO values(21, N'InvoiceID_SK','int','Store invoice ID surrogate key','1',null)
insert into COLUMN_INFO values(21, N'Branch_SK','int','Store branch ID surrogate key','1',69)
insert into COLUMN_INFO values(21, N'customer_typeID_SK','int','Store cuustomer type ID surrogate key','1',72)
insert into COLUMN_INFO values(21, N'Gender','varchar','Store customer gender','MALE',null)
insert into COLUMN_INFO values(21, N'ProductID_SK','int','Store product ID surrogate key','1',76)
insert into COLUMN_INFO values(21, N'ProductLineID_SK','int','Store product line ID surrogate key','1',74)
insert into COLUMN_INFO values(21, N'Quantity','int','Store product quantity','2',null)
insert into COLUMN_INFO values(21, N'Tax 5%','float','Store tax amount','26.1415',null)
insert into COLUMN_INFO values(21, N'Total','float','Store Total amouunt of invoice','548.9715',null)
insert into COLUMN_INFO values(21, N'DateKey','varchar','Store invoice create Date key','20231223',60)
insert into COLUMN_INFO values(21, N'TimeKey','varchar','Store invoice create Time key','2359',64)
insert into COLUMN_INFO values(21, N'paymentID_SK','int','Store payment ID surrogate key','1',67)
insert into COLUMN_INFO values(21, N'cogs','float','Store cost of goods sold','522.83',null)
insert into COLUMN_INFO values(21, N'gross margin percentage','float','Store gross margin percentage amount','4.761904762',null)
insert into COLUMN_INFO values(21, N'gross income','float','Store gross income amount','26.1415',null)
insert into COLUMN_INFO values(21, N'Rating','float','Store ratings statistics','9.1',null)


select * from column_info
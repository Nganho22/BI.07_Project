
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

SELECT * FROM DATA_STORE_INFO

INSERT INTO DATA_TABLE_INFO VALUES (1, 'DATA_FLOW','METADATA','Store the timestamps of data source flow that ETL to DW', NULL);

INSERT INTO DATA_TABLE_INFO VALUES (2, 'city','Stage','Store City data about the city from source', NULL)

insert into DATA_TABLE_INFO VALUES (2,'product_line','Stage','Store Product Line data from source', NULL)

INSERT INTO DATA_TABLE_INFO VALUES (2,'product','Stage','Store Product data from source', NULL)

INSERT INTO DATA_TABLE_INFO VALUES(2, 'supermarket_sales','Stage','Store the Invoice data of supermarket_sales from source', NULL)

INSERT INTO DATA_TABLE_INFO VALUES(3,'DATE','Master tables(NDS)', 'Store date data', GETDATE())

INSERT INTO DATA_TABLE_INFO VALUES(3, 'TIME','Master tables(NDS)', 'Store time data', GETDATE())

INSERT INTO DATA_TABLE_INFO VALUES(3, 'payment','Master tables(NDS)','Store payment type', NULL)

INSERT INTO DATA_TABLE_INFO VALUES(3, 'city','Master tables(NDS)', 'Store city data', NULL)

INSERT INTO DATA_TABLE_INFO VALUES(3,'customer_type', 'Master tables(NDS)','Store customer type', NULL)

INSERT INTO DATA_TABLE_INFO VALUES (3,'product_line', 'Master tables(NDS)','Store product line data', NULL)

INSERT INTO DATA_TABLE_INFO VALUES(3, 'product','Master tables(NDS)','Store product info data', NULL)

INSERT INTO DATA_TABLE_INFO VALUES(3,'supermarket_sales','Transaction table(NDS)', 'Store the invoice data of supermarket_sales', NULL)


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
INSERT INTO COLUMN_INFO VALUES (2, N'Branch', N'nvarchar',NULL,'A',NULL)

INSERT INTO COLUMN_INFO VALUES (2, N'City',N'nvarchar',NULL, N'Yangon',NULL)
--PRODUCT LINE STAGE
INSERT INTO COLUMN_INFO VALUES(3,N'Product line',N'nvarchar',NULL,'Health and beauty',NULL)
INSERT INTO COLUMN_INFO VALUES(3,N'ProductLineID',N'nvarchar',NULL,'PD001',NULL)

--PRODUCT STAGE
INSERT INTO COLUMN_INFO VALUES(4,N'ProductID', N'nvarchar',NULL,'PID01',NULL)
INSERT INTO COLUMN_INFO VALUES(4, N'Unit price',N'FLOAT',NULL,'74,69',NULL)
INSERT INTO COLUMN_INFO VALUES(5, N'ProductLine',N'nvarchar',null,'PD001',null)
--supermarket_sales
insert into COLUMN_INFO values(
5, N'Invoice ID',N'nvarchar',null,'750-67-8428',null)

insert into COLUMN_INFO values(5, N'Branch',N'nvarchar',NULL,N'A',NULL)
Insert into COLUMN_INFO values(5,'Customer type','nvarchar',null,N'Member',null)
insert into COLUMN_INFO values(5,'Gender',N'nvarchar',null,'Female',null)
insert into COLUMN_INFO values(5,'ProductID','nvarchar',null,'PID01',NULL)
INSERT INTO COLUMN_INFO VALUES(5,'Quantity','int',null,'1',null)
insert into COLUMN_INFO values(5,'Tax 5%','float',null,'26,1415',null)
insert into COLUMN_INFO values(5,'Total','float',null,'548,9715',null)
insert into COLUMN_INFO values(5,'Date','Date',null,'2019-01-05',null)
insert into COLUMN_INFO values(5,'Time','Date',null,'2019-01-05',null)

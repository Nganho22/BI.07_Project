USE MASTER
CREATE DATABASE BI07_MOVIE_METADATA
GO
USE BI07_MOVIE_METADATA
GO

CREATE TABLE [dbo].[DATA_FLOW](
	[ID] [int] IDENTITY(1,1) NOT NULL PRIMARY KEY,
	[SOURCE_NAME] [varchar](30) NULL,
	[LSET] [datetime] NULL,
	[CET] [datetime] NULL,
)
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

INSERT INTO DATA_STORE_INFO VALUES('BI07_MOVIE_METADATA', 'Describes whole data information in system');
INSERT INTO DATA_STORE_INFO VALUES ('BI07_MOVIE_STAGE','An internal data store used for transforming and preparing the data obtained from the source systems, before being loaded to other data stores in DW')
INSERT INTO DATA_STORE_INFO VALUES ('BI07_MOVIE_NDS','An internal master data store in the form of normalized relational databases used for integrating data from various source systems captured in Stage database')
INSERT INTO DATA_STORE_INFO VALUES ('BI07_MOVIE_DDS','A user-facing data store, in the form of relational databases used for supporting analytical queries')

--METADATA
INSERT INTO DATA_TABLE_INFO VALUES (1, 'DATA_FLOW','METADATA','Store the timestamps of data source flow that ETL to DW', NULL);

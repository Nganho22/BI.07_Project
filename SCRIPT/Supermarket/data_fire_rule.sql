USE BI07_METADATA
GO

CREATE TABLE [dbo].[DATA_FIRE](
	ID int IDENTITY(1,1) NOT NULL,
	[COLUMN_ID] [int] NOT NULL,
	[RULE] [varchar](255) NULL
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



INSERT INTO DATA_FIRE VALUES(24,'	[Day]>0 && [Day]<32 && [Month]==1 ||
									[Day]>0 && [Day]<30 && [Month]==2 && [Year]%4 == 0 && [Year]%100 == 0 ||
									[Day]>0 && [Day]<30 && [Month]==2 && [Year]%400 == 0 ||
									[Day]>0 && [Day]<29 && [Month]==2 || 
									[Day]>0 && [Day]<32 && [Month]==3 ||
									[Day]>0 && [Day]<31 && [Month]==4 ||
									[Day]>0 && [Day]<32 && [Month]==5 ||
									[Day]>0 && [Day]<31 && [Month]==6 ||
									[Day]>0 && [Day]<32 && [Month]==7 ||
									[Day]>0 && [Day]<32 && [Month]==8 ||
									[Day]>0 && [Day]<31 && [Month]==9 ||
									[Day]>0 && [Day]<32 && [Month]==10 ||
									[Day]>0 && [Day]<31 && [Month]==11 ||
									[Day]>0 && [Day]<32 && [Month]==12 || ? [Day] : 1')
INSERT INTO DATA_FIRE VALUES(25, '[Month]>=1 || [Month]<=12 ? [Month] : 1')
INSERT INTO DATA_FIRE VALUES(26, '[Year]<1 || [Year]>Year(GETDATE()) ? Year(GETDATE()) : [Year]')
INSERT INTO DATA_FIRE VALUES(28, '[Hour]<0 || [Hour]>23 ? 12 : [Hour]')
INSERT INTO DATA_FIRE VALUES(29, '[Minute]<0 || [Minute]>59 ? 0 : [Minute]')
INSERT INTO DATA_FIRE VALUES(42, '[Unit price]<0 ? 1 : [Unit price]')
INSERT INTO DATA_FIRE VALUES(50, '[Quantity]<0 ? 1 : [Quantity]')
INSERT INTO DATA_FIRE VALUES(51, '[Tax 5%]!=[Cogs]*0.05 ? [Cogs]*0.05 : [Tax 5%]')
INSERT INTO DATA_FIRE VALUES(52, '[Total]!=[Cogs]-[Tax 5%] ? [Cogs]-[Tax 5%] : [Total]')

INSERT INTO [DATA_FIRE] VALUES(42, '[Unit price] < 0 || ISNULL([Unit price]) ? 1 :  [Unit price]');
INSERT INTO [DATA_FIRE] VALUES(50, '[Quantity] < 0 || ISNULL([Quantity]) ? 1 : [Total]');
INSERT INTO [DATA_FIRE] VALUES(51, '[Tax 5%] < 0 || ISNULL([Tax 5%]) ? 1 : [Tax 5%] = [Cogs] * 5%');
INSERT INTO [DATA_FIRE] VALUES(52, '[Total] < 0 || ISNULL([Total]) ? 1 : [Total] = [Cogs] - [Tax 5%]');
INSERT INTO [DATA_FIRE] VALUES(56, '[cogs] < 0 || ISNULL([cogs]) ? 1 : [cogs] = [Quantity] * [product].[Unit price]');
INSERT INTO [DATA_FIRE] VALUES(57, '[gross margin percentage] < 0 || ISNULL([gross margin percentage]) ? 1 : 4,761904762');
INSERT INTO [DATA_FIRE] VALUES(58, '[gross income] < 0 || ISNULL([gross income]) ? 1 : [Total] * [gross margin percentage]');
INSERT INTO [DATA_FIRE] VALUES(59, '[Rating] <= 0 || [Rating] >= 10 || ISNULL([Rating]) ? 0 : [Rating]');

SELECT * FROM COLUMN_INFO WHERE TABLE_ID>=6 AND TABLE_ID<=13

truncate table COLUMN_INFO
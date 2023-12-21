USE BI07_MOVIE_METADATA
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

select * from DATA_TABLE_INFO --tableID 10 -> 15
select * from [DATA_FIRE]

INSERT INTO DATA_FIRE VALUES(43,'([Day]>0 && [Day]<32 && [Month]==1,3,5,5,7,8,10,12)||([Day]>0 && [Day]<30 && [Month]==2 && [Year]%4 == 0 && [Year]%100 == 0 || ([Day]>0 && [Day]<30 && [Month]==2 && [Year]%400 == 0)||([Day]>0 && [Day]<31 && [Month]==4,6,9,11) ? [Day] : 1')
INSERT INTO DATA_FIRE VALUES(44, '[Month]>=1 || [Month]<=12 ? [Month] : 1')
INSERT INTO DATA_FIRE VALUES(45, '[Year]<1 || [Year]>Year(GETDATE()) ? Year(GETDATE()) : [Year]')
INSERT INTO DATA_FIRE VALUES(46, '[Quarter] < 1 || [Quarter] > 4 ? 1 : [Quarter]')

INSERT INTO DATA_FIRE VALUES(56, '[Price] < 0 ? 0 : [Price]')
INSERT INTO DATA_FIRE VALUES(77, '[total_sales] < 0 ? 0 : [total_sales]')
INSERT INTO DATA_FIRE VALUES(78, '[tickets_sold] < 0 ? 0 : [tickets_sold]')

INSERT INTO DATA_FIRE VALUES(81, '[tickets_out] < 0 || [tickets_out] > [tickets_sold] ? 0 : [tickets_out]')
INSERT INTO DATA_FIRE VALUES(82, '[Standard_Seats_out] < 0 || [Standard_Seats_out] > [Standard_Seats_sold] ? 0 : [Standard_Seats_out]')
INSERT INTO DATA_FIRE VALUES(83, '[VIP_Seats_out] < 0 || [VIP_Seats_out] > [VIP_Seats_sold] ? 0 : [VIP_Seats_out]')
INSERT INTO DATA_FIRE VALUES(84, '[ticket_use] < 0 || [ticket_use] > [tickets_sold]	? 0 : [ticket_use]')
INSERT INTO DATA_FIRE VALUES(85, '[occur_perc] < 0 || [occur_perc] > 100 ? 0 : [occur_perc]')




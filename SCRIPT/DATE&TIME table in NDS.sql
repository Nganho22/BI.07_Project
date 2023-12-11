
CREATE TABLE DATE_MASTER(
	[DateKey] [varchar](8) NOT NULL,
	[Day] [int] NULL,
	[Month] [int] NULL,
	[Year] [int] NULL,
PRIMARY KEY (DateKey)
)

CREATE TABLE TIME_MASTER(
	[TimeKey] [varchar](4) NOT NULL,
	[Hour] [int] NULL,
	[Minute] [int] NULL,
PRIMARY KEY (TimeKey)
)



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











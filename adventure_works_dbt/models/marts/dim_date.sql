

WITH 
date_table AS (

    {{ dim_date_azure('2011-01-01', '2014-12-31') }}

), date_dimension AS (
    SELECT
        d AS Date
    FROM date_table
)

SELECT 
    Date,
    DATEPART(year, date) AS Year,
    DATEPART(quarter, date) AS Quarter,
    DATEPART(month, date) AS Month,
    DATENAME( month , Date ) AS MonthName,
    DATEPART(week, date) AS Week,
    DATEPART(weekday, date) AS WeekDay,
    DATENAME(weekday, date) AS WeekDayName
FROM date_dimension;

SELECT * 
FROM dbo.['2018$'];

SELECT * 
FROM dbo.['2019$'];

SELECT *
FROM dbo.['2020$'];

/*Now combined all data from the top - to unionized all of these to one for analysis*/

SELECT * 
FROM dbo.['2018$']
UNION
SELECT * 
FROM dbo.['2019$']
UNION
SELECT *
FROM dbo.['2020$'];


/*Now name the table as hotels*/
WITH hotels AS 
(SELECT * 
FROM dbo.['2018$']
UNION
SELECT * 
FROM dbo.['2019$']
UNION
SELECT *
FROM dbo.['2020$'])

SELECT *
FROM hotels; 

/* We want to see if the hotel revenue growing by year, let's see if we have a revenue column, 
   but we have the ADR and the total stays in weeks in and week night - we have to create a new column in order to see that 

   First let's add stays_in_week_nights and stays_in_week_nights */

WITH hotels AS 
(SELECT * 
FROM dbo.['2018$']
UNION
SELECT * 
FROM dbo.['2019$']
UNION
SELECT *
FROM dbo.['2020$'])


SELECT stays_in_week_nights+stays_in_weekend_nights 
FROM hotels;


/* Now we want to mutiple stays_in_week_nights+stays_in_weekend_nights by ADR - name the column revenue */ 
WITH hotels AS 
(SELECT * 
FROM dbo.['2018$']
UNION
SELECT * 
FROM dbo.['2019$']
UNION
SELECT *
FROM dbo.['2020$'])


SELECT (stays_in_week_nights+stays_in_weekend_nights)*adr 
AS revenue
FROM hotels;

/* Now we like to see this increasing by year */
WITH hotels AS 
(SELECT * 
FROM dbo.['2018$']
UNION
SELECT * 
FROM dbo.['2019$']
UNION
SELECT *
FROM dbo.['2020$'])


SELECT 
arrival_date_year,
(stays_in_week_nights+stays_in_weekend_nights)*adr 
AS revenue
FROM hotels;

/*However we want to group it and Sum it by Year */ 
WITH hotels AS 
(SELECT * 
FROM dbo.['2018$']
UNION
SELECT * 
FROM dbo.['2019$']
UNION
SELECT *
FROM dbo.['2020$'])


SELECT 
arrival_date_year,
ROUND(SUM((stays_in_week_nights+stays_in_weekend_nights)*adr),2)
AS revenue
FROM hotels
GROUP BY arrival_date_year;

/* We can say that our revenue is growing - now we want it broken down by hotel type */ 
WITH hotels AS 
(SELECT * 
FROM dbo.['2018$']
UNION
SELECT * 
FROM dbo.['2019$']
UNION
SELECT *
FROM dbo.['2020$'])

SELECT 
arrival_date_year,
hotel,
ROUND(SUM((stays_in_week_nights+stays_in_weekend_nights)*adr),2)
AS revenue
FROM hotels
GROUP BY arrival_date_year, hotel;

/* Now we can see that 2020 has a incomplete DataSet - Resort Hotel between 2018 and 2019 there is a big difference */
/* Remember we brought in data sets market_segment and meal_cost */
SELECT * 
FROM dbo.market_segment$;

SELECT *
FROM dbo.meal_cost$;

/* For Discount we can see the Discount applied for each market_segment*/
/*Hotels also has a market_segment column so we can join the Discount column to our hotel table*/

WITH hotels AS 
(SELECT * 
FROM dbo.['2018$']
UNION
SELECT * 
FROM dbo.['2019$']
UNION
SELECT *
FROM dbo.['2020$'])

SELECT *
FROM hotels
left join dbo.market_segment$
on hotels.market_segment = market_segment$. market_segment;

/* Now we can see that the columns from dbo.market_segment$ are in dbo.hotels */ 
/* Now we want to left join the dbo.meal_cost$ */

SELECT *
FROM dbo.meal_cost$;

WITH hotels AS 
(SELECT * 
FROM dbo.['2018$']
UNION
SELECT * 
FROM dbo.['2019$']
UNION
SELECT *
FROM dbo.['2020$'])

SELECT *
FROM hotels
LEFT JOIN dbo.market_segment$
ON hotels.market_segment = market_segment$. market_segment
LEFT JOIN dbo.meal_cost$
ON meal_cost$.meal = hotels.meal;

/*Now we have developed our SQL for POWER BI*/ 













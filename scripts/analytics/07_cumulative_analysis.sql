--Cumulative Analysis is
-- Aggregating the data progressively over time, helps to understand whether the business is growing or declining
--Formula: ∑[Cumulative Measure] By [Date Dimension]
--example: Running Total Sales By Year / Moving Average of Sales By Month

--Calculate the total sales per month
--and the running total of sales over time

--calculate the running total using window function
SELECT --use subquery to calc
order_date, 
total_sales, 
SUM(total_sales) OVER (PARTITION BY order_date ORDER BY order_date) AS running_total_sales -- window function
FROM(
SELECT
DATETRUNC(year, order_date) AS order_date,
SUM(sales_amount) AS total_sales 
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(year, order_date))t
--result: adding each row's value to the sum of all the previous rows's values 

--Find moving average
SELECT 
order_date, 
total_sales, 
SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales, -- window function
AVG(avg_price) OVER (ORDER BY order_date) AS moving_average_price
FROM(
SELECT
DATETRUNC(year, order_date) AS order_date,
SUM(sales_amount) AS total_sales,
AVG(price) AS avg_price 
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(year, order_date))t

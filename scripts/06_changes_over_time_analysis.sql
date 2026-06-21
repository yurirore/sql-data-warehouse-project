-- Changes over time aka Trends
--Formula : ∑[MEASURE] BY [DATE DIMENSION]
--EXAMPLE: total sales by year / average cost by month

--ANALYZE SALES OVER TIME (years)
--HIGH LEVEL OVERVIEW INSIGHTS 
SELECT
YEAR(order_date) as order_year,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) as total_customers,
SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date)
ORDER BY YEAR(order_date)

--ANALYZE SALES OVER TIME (months over the years)
SELECT
MONTH(order_date) as order_month,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) as total_customers,
SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY MONTH(order_date)
ORDER BY MONTH(order_date) DESC;

--ANALYZE SALES OVER TIME (monthly by each year)
SELECT
YEAR(order_date) as order_year,
MONTH(order_date) as order_month,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) as total_customers,
SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY YEAR(order_date), MONTH(order_date)

-- CONTINUED FROM MONTHLY BY EACH YEAR, OR CAN USE DATETRUNC() FUNCTION TO GET THE SAME RESULT, WHERE IT ROUNDS A DATE OR TIMESTAMP TO A SPECIFIED DATE
SELECT
DATETRUNC(month, order_date) as order_date,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) as total_customers,
SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date) 
ORDER BY DATETRUNC(month, order_date) 

--OR CAN USE FORMAT() FOR A SPECIFIED FORMAT 
SELECT
FORMAT(order_date, 'yyyy-MMM') as order_date,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) as total_customers,
SUM(quantity) as total_quantity
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY FORMAT(order_date, 'yyyy-MMM')
ORDER BY FORMAT(order_date, 'yyyy-MMM')

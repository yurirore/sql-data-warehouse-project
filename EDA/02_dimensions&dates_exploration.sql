--DIMENSION EXPLORATION
--1) explore all countries our customers come from
SELECT DISTINCT country FROM gold.dim_customers

--2) explore all categories "THE MAJOR DIVISIONS"
SELECT DISTINCT category, subcategory, product_name FROM gold.dim_products
ORDER BY 1,2,3

--DATE EXPLORATION
--1) find the date of the first and last order
SELECT MIN(order_date) AS first_order_date,MAX(order_date) AS last_order_date from gold.fact_sales

--2) how many years of sale are available
SELECT DATEDIFF(YEAR, MIN(order_date), MAX(order_date)) as order_range_years FROM gold.fact_sales

--3) find the youngest and oldest customer
SELECT
MIN(birthdate) AS oldest_birthdate,
MAX(birthdate) AS youngest_birthdate
FROM gold.dim_customers

--4) find the age difference between the youngest and oldest customer
SELECT DATEDIFF(year, MIN(birthdate), MAX(birthdate)) as age_difference FROM gold.dim_customers


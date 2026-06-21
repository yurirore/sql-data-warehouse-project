-- RANKING ANALYSIS
--FORMULA: Rank[Dimension] By ∑[Measure]
-- EXAMPLES:
--RANK COUNTRIES BY TOTAL SALES
--TOP 5 PRODUCTS BY QUANTITY
--BOTTOM 3 CUSTOMERS BY TOTAL ORDERS

-- Which 5 products generate the highest revenue?
SELECT TOP 5
p.product_name, SUM(f.sales_amount) total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;

SELECT TOP 5
p.subcategory, SUM(f.sales_amount) total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.subcategory
ORDER BY total_revenue DESC;
--What are the 5 worst-performing products in terms of sales?
SELECT TOP 5
p.product_name, SUM(f.sales_amount) total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue;

SELECT TOP 5
p.subcategory, SUM(f.sales_amount) total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.subcategory
ORDER BY total_revenue;

--WINDOW FUNCTIONS, SAME PURPOSE, MORE FLEXIBILITY IN ADDING COLUMNS OR AGGREGATIONS
SELECT * FROM (
SELECT 
p.product_name, SUM(f.sales_amount) total_revenue,
ROW_NUMBER() OVER (ORDER BY SUM(f.sales_amount) DESC) AS rank_products
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name)t 
WHERE rank_products <= 5

--RANK FUNCTION, ALSO WINDOW FUNCTION BUT HANDLES TIES DIFFERENTLY 
SELECT * FROM (
SELECT 
p.product_name, SUM(f.sales_amount) total_revenue,
RANK() OVER (ORDER BY SUM(f.sales_amount) DESC) AS rank_products
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name)t 
WHERE rank_products <= 5

--Find the top 10 customers who have generated the highest revenue
SELECT TOP 10
c.first_name, c.last_name, c.customer_key, SUM(f.sales_amount) total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY c.customer_key, c.first_name,c.last_name
ORDER BY total_revenue DESC;

--Find 3 customers with the fewest orders placed
--Find the top 10 customers who have generated the highest revenue
SELECT TOP 3
c.first_name, c.last_name, c.customer_key, 
COUNT(DISTINCT order_number) total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY c.customer_key, c.first_name,c.last_name
ORDER BY total_orders;

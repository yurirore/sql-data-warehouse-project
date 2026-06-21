--Performance Analysis, compare the current value to a target value, help measure success and compare performance

--Formula: Current[Measure] - Target[Measure]
--Example: Current Sales - Average sales / Current year sales - Previous year sales / Current sales - Lowest sales


-- Analyze the yearly performance of products by comparing their sales to both the average sales performance of the product and the previous year's sales.
WITH yearly_product_sales AS ( --second step: CTE FOR CALCULATING AVERAGE SALES and compare
SELECT
YEAR(f.order_date) AS order_year,
p.product_name,
SUM(f.sales_amount) AS current_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
WHERE order_date IS NOT NULL
GROUP BY
YEAR(f.order_date), p.product_name
--1) first step: this is the yearly performance of products
)
SELECT
order_year,
product_name,
current_sales,
AVG(current_sales) OVER (PARTITION BY product_name) avg_sales,
current_sales - AVG(current_sales) OVER (PARTITION BY product_name) AS diff_avg,
CASE WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Average'
    WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name)< 0 THEN 'Below Average'
    ELSE 'Average' 
END avg_change,
LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) py_sales, 
current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) diff_py,
--LAG() to access previous value of the current_sales, partition data by product_name because we focus by the product, and sort the data by years (previous years), ascending order
CASE WHEN LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year)> 0 THEN 'Increase'
    WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year)< 0 THEN 'Decrease'
    ELSE 'No Change' 
END py_change
--This is called Year-over-year Analysis, good for long term trend analysis
--For month-over-month analysis, just change the year diemension to month, and good for short term seasonal trend analysis
FROM yearly_product_sales
ORDER BY product_name, order_year

SELECT * FROM gold.fact_sales
    

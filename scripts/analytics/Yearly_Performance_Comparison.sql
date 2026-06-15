-- Analyze the YEARLY PERFORMANCE of products by comparing each product's sales to both
-- its AVERAGE sales performance and the PREVIOUS year's sales.
WITH sales_yearly AS (
	SELECT
	YEAR(order_date) AS order_year,
	product_key,
	SUM(sales_amount) sales_yearly_total
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY YEAR(order_date), product_key
)
,
previous_year_sales AS (
	SELECT
	YEAR(order_date) AS order_year,
	product_key,
	SUM(sales_amount) sales_yearly_total
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY YEAR(order_date), product_key
)
,
total_avg_sales AS (
	SELECT
	product_key,
	AVG(sales_amount) avg_total_sales
	FROM gold.fact_sales
	GROUP BY product_key
)

SELECT
y.order_year,
p.product_name,
y.sales_yearly_total,
x.sales_yearly_total AS previous_year_sales,
y.sales_yearly_total - x.sales_yearly_total AS sales_yearly_change,
a.avg_total_sales,
y.sales_yearly_total - a.avg_total_sales AS current_versus_average_sales
FROM sales_yearly y
LEFT JOIN total_avg_sales a
	ON y.product_key = a.product_key
LEFT JOIN sales_yearly x
	ON y.product_key = x.product_key AND y.order_year = x.order_year+1
LEFT JOIN gold.dim_products p
	ON p.product_key = y.product_key
ORDER BY y.product_key, y.order_year
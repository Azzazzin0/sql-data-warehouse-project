WITH monthly_product_sales AS (
SELECT
month(f.order_date) AS order_month,
p.product_name,
SUM(f.sales_amount) current_sales
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
	ON f.product_key = p.product_key
WHERE f.order_date IS NOT NULL
GROUP BY month(f.order_date), p.product_name
)

SELECT
order_month,
product_name,
current_sales,
AVG(current_sales) OVER (PARTITION BY product_name) avg_sales,
current_sales - AVG(current_sales) OVER (PARTITION BY product_name) AS diff_avg,
CASE
	WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Average'
	WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Average'
	ELSE 'Average'
END AS diff_avg_classification,
LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_month) AS prev_month_sales,
current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_month) prev_month_diff,
CASE
	WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_month) > 0 THEN 'Increase'
	WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_month) < 0 THEN 'Decrease'
	ELSE 'No Change'
END AS diff_py_classification

FROM monthly_product_sales
ORDER BY product_name, order_month
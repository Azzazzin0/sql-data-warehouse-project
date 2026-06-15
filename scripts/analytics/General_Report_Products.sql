WITH base_query AS (
SELECT
	f.order_number,
	p.product_key,
	p.product_name,
	p.category,
	p.subcategory,
	p.cost,
	f.customer_key,
	f.order_date,
	f.sales_amount,
	f.quantity
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
	ON f.product_key = p.product_key
)

SELECT
product_key,
product_name,
category,
subcategory,
cost,
MAX(order_date) AS last_order_date,
COUNT(DISTINCT order_number) AS total_orders,
COUNT(DISTINCT customer_key) AS total_customers,
SUM(sales_amount) AS total_sales,
SUM(quantity) AS total_quantity,
ROUND(AVG(CAST(sales_amount AS FLOAT)/NULLIF(quantity,0)),1) AS avg_selling_price
FROM base_query
GROUP BY 
product_key,
product_name,
category,
subcategory,
cost
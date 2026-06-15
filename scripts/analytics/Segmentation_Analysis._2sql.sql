WITH customer_categories AS (
SELECT
f.customer_key,
c.first_name,
c.last_name,
SUM(sales_amount) AS amount_spent,
CASE
	WHEN SUM(sales_amount) > 5000 THEN 'Over 5000'
	ELSE 'Less Than 5000'
END AS spending_category,
MIN(f.order_date) AS first_order_date,
MAX(f.order_date) AS last_order_date,
DATEDIFF(MONTH,MIN(f.order_date),MAX(f.order_date)) AS months_active
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
	ON f.customer_key = c.customer_key
GROUP BY f.customer_key, c.first_name, c.last_name
)
,
customer_final_segment AS (
SELECT 
*,
CASE
	WHEN months_active >= 12 AND spending_category = 'Over 5000' THEN 'VIP'
	WHEN months_active >= 12 AND spending_category = 'Less Than 5000' THEN 'Regular'
	ELSE 'New'
END AS client_segment
FROM customer_categories
)

SELECT
client_segment,
COUNT(customer_key) customer_count
FROM customer_final_segment
GROUP BY client_segment
ORDER BY customer_count DESC
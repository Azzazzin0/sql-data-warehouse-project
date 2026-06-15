SELECT TOP 5
p.product_name,
SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
	ON s.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC
;
SELECT TOP 5
p.product_name,
SUM(s.sales_amount) AS total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
	ON s.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue ASC
;
SELECT
*
FROM
	(SELECT
	p.product_name,
	SUM(s.sales_amount) AS total_revenue,
	ROW_NUMBER() OVER (ORDER BY SUM(s.sales_amount) DESC) AS rank_products
	FROM gold.fact_sales s
	LEFT JOIN gold.dim_products p
		ON s.product_key = p.product_key
	GROUP BY p.product_name)t
WHERE rank_products <= 5
;
SELECT
*
FROM
	(SELECT
	c.customer_id,
	c.first_name,
	c.last_name,
	SUM(s.sales_amount) AS total_revenue,
	ROW_NUMBER() OVER (ORDER BY SUM(s.sales_amount) DESC) AS rank_products
	FROM gold.fact_sales s
	LEFT JOIN gold.dim_products p
		ON s.product_key = p.product_key
	LEFT JOIN gold.dim_customers c
		ON s.customer_key= c.customer_key
	GROUP BY c.customer_id, c.first_name, c.last_name)t
WHERE rank_products <= 10
;

SELECT
*
FROM
	(SELECT
	c.customer_id,
	c.first_name,
	c.last_name,
	SUM(s.sales_amount) AS total_revenue,
	ROW_NUMBER() OVER (ORDER BY SUM(s.sales_amount) ASC) AS rank_products
	FROM gold.fact_sales s
	LEFT JOIN gold.dim_products p
		ON s.product_key = p.product_key
	LEFT JOIN gold.dim_customers c
		ON s.customer_key= c.customer_key
	GROUP BY c.customer_id, c.first_name, c.last_name)t
WHERE rank_products <= 10
;

SELECT
*
FROM
	(SELECT
	c.customer_id,
	c.first_name,
	c.last_name,
	COUNT(DISTINCT s.order_number) AS total_orders,
	ROW_NUMBER() OVER (ORDER BY SUM(s.sales_amount) DESC) AS rank_products
	FROM gold.fact_sales s
	LEFT JOIN gold.dim_products p
		ON s.product_key = p.product_key
	LEFT JOIN gold.dim_customers c
		ON s.customer_key= c.customer_key
	GROUP BY c.customer_id, c.first_name, c.last_name)t
WHERE rank_products <= 10
;

SELECT
*
FROM
	(SELECT
	c.customer_id,
	c.first_name,
	c.last_name,
	COUNT(DISTINCT s.order_number) AS total_orders,
	ROW_NUMBER() OVER (ORDER BY SUM(s.sales_amount) ASC) AS rank_products
	FROM gold.fact_sales s
	LEFT JOIN gold.dim_products p
		ON s.product_key = p.product_key
	LEFT JOIN gold.dim_customers c
		ON s.customer_key= c.customer_key
	GROUP BY c.customer_id, c.first_name, c.last_name)t
WHERE rank_products <= 10

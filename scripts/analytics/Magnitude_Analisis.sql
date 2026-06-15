SELECT 
country,
COUNT(customer_id) AS Number_of_Customers
FROM gold.dim_customers
GROUP BY country
ORDER BY COUNT(customer_id) DESC
;
SELECT
gender,
COUNT(customer_id) AS Number_of_Customers
FROM gold.dim_customers
GROUP BY gender
ORDER BY COUNT(customer_id) DESC
;
SELECT
category,
COUNT(product_id) AS Number_of_Products
FROM gold.dim_products
GROUP BY category
ORDER BY COUNT(product_id) DESC
;
SELECT
category,
AVG(cost) AS Average_Cost
FROM gold.dim_products
GROUP BY category
ORDER BY AVG(cost) DESC
;
SELECT
p.category,
SUM(s.sales_amount) Total_Revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_products p
	ON p.product_key = s.product_key
GROUP BY p.category
;
SELECT
c.customer_id,
c.first_name,
c.last_name,
SUM(f.sales_amount) Total_Revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
	ON f.customer_key= c.customer_key
GROUP BY 
c.customer_id, c.first_name, c.last_name
ORDER BY SUM(f.sales_amount) DESC
;
SELECT
c.country,
SUM(f.quantity) Items_Sold
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
	ON f.customer_key= c.customer_key
GROUP BY c.country 
ORDER BY SUM(f.quantity) DESC

-- Exploring database schema

SELECT *
FROM INFORMATION_SCHEMA.TABLES

SELECT *
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers'

-- Exploring the dimensions
SELECT DISTINCT
country
FROM gold.dim_customers

SELECT DISTINCT
category,
subcategory,
product_name
FROM gold.dim_products
ORDER BY 1,2,3

-- Exploring date boundaries
SELECT 
MIN(birthdate) AS minbd,
DATEDIFF(YEAR,MIN(birthdate),GETDATE()) AS oldest_age_cust,
MAX(birthdate) AS maxbd,
DATEDIFF(YEAR,MAX(birthdate),GETDATE()) AS youngest_age_cust,
DATEDIFF(YEAR,MIN(birthdate),MAX(birthdate)) AS bd_datediff,
MIN(create_date) AS min_create_date,
MAX(create_date) AS max_create_date,
DATEDIFF(YEAR,MIN(create_date),MAX(create_date)) AS create_date_datediff
FROM gold.dim_customers
;
SELECT
MIN(start_date) AS min_start_date,
MAX(start_date) AS max_start_date,
DATEDIFF(YEAR,MIN(start_date),MAX(start_date)) AS start_date_datediff
FROM gold.dim_products
;
SELECT
MIN(order_date) AS min_order_date,
MAX(order_date) AS max_order_date,
DATEDIFF(YEAR,MIN(order_date),MAX(order_date)) AS order_date_datediff,
MIN(shipping_date) AS min_shipping_date,
MAX(shipping_date) AS max_shipping_date,
DATEDIFF(YEAR,MIN(shipping_date),MAX(shipping_date)) AS shipping_date_datediff,
MIN(due_date) AS min_due_date,
MAX(due_date) AS max_due_date,
DATEDIFF(YEAR,MIN(due_date),MAX(due_date)) AS due_date_datediff
FROM gold.fact_sales

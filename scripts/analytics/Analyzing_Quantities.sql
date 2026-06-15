/*SELECT
SUM(sales_amount) AS Total_Sales,
SUM(quantity) AS Total_Items_Sold,
AVG(price) AS Average_Price,
COUNT(DISTINCT order_number) AS Number_Of_Orders
FROM gold.fact_sales
;
SELECT
COUNT(product_key) Number_Of_Products
FROM gold.dim_products
;
SELECT
COUNT(customer_key) Number_Of_Customers
FROM gold.dim_customers
;
SELECT
COUNT(DISTINCT customer_key) Customers_With_Orders
FROM gold.fact_sales
;
*/
SELECT  'Total Sales' AS Measure_Name , SUM(sales_amount) AS Measure_Value FROM gold.fact_sales
UNION ALL
SELECT  'Total Items Sold', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT  'Average Price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT  'Number Of Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT  'Number Of Products', COUNT(product_key) FROM gold.dim_products
UNION ALL
SELECT 'Number Of Customers', COUNT(customer_key) FROM gold.dim_customers
UNION ALL
SELECT 'Customers With Orders', COUNT(DISTINCT customer_key) FROM gold.fact_sales

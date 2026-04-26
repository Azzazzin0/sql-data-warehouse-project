Data Dictionary for Gold Layer
Overview
The Gold Layer is the vusniess-level data representation, structured to support analytical and reporting use cases. It consists of dimension tables and fact tables for specific buisness metrics.

1. gold.dim_customers
  - Purpose: Stores customer details enriched with demographic and geographic data.
  - Columns:

| Column Name | Data Type | Description |
| -------- | ------- | ------- |
| customer_key  | INT    | Surrogate Key |
| customer_id | INT    | insert  |
| customer_number    | NVARCHAR(50)   | insert  |
| first_name    | NVARCHAR(50)   | insert  |
| last_name    | NVARCHAR(50)   | insert  |
| country    | NVARCHAR(50)   | insert  |
| gender    | NVARCHAR(50)   | insert  |
| marital_status    | NVARCHAR(50)   | insert  |
| birthdate    | DATE   | insert  |
| create_date    | DATE   | insert  |

2. gold.dim_products
  - Purpose: Provides information about the products and their attributes.
  - Columns:

| Column Name | Data Type | Description |
| -------- | ------- | ------- |
| product_key  | INT    | Surrogate Key |
| product_id | INT    | insert  |
| product_number    | NVARCHAR(50)   | insert  |
| product_name    | NVARCHAR(50)   | insert  |
| category_id    | NVARCHAR(50)   | insert  |
| category    | NVARCHAR(50)   | insert  |
| subcategory    | NVARCHAR(50)   | insert  |
| maINTenance    | NVARCHAR(50)   | insert  |
| cost    | INT   | insert  |
| product_line    | NVARCHAR(50)   | insert  |
| start_date    | DATE   | insert  |


3. gold.fact_sales
  - Purpose: Stores transactional sales data for analytical purposes.
  - Columns:

| Column Name | Data Type | Description |
| -------- | ------- | ------- |
| order_number  | NVARCHAR(50)    | Surrogate Key |
| product_key | INT    | insert  |
| customer_key | INT    | insert  |
| order_date    | DATE   | insert  |
| shipping_date    | DATE   | insert  |
| due_date    | DATE   | insert  |
| due_date    | DATE   | insert  |
| sales_amount | INT    | insert  |
| quantity | INT    | insert  |
| price | INT    | insert  |

/*
====================================================================
Quality Checks
====================================================================
Scipt Purpose:
	This script performs various quality checks for data consistency, accuracy,
	and standardization across the 'Silver' schema. It includes checks for:
		- Null or duplicate primary keys.
		- Unwanted spaces in string fields.
		- Data standardization and consitency.
		- Invalid date ranges and orders.
		- Data consistency between related fields

Usage Notes:
	- Run these checks after data loading Silver layer.
	- Investigate and resolve any discrepancies found during checks.
====================================================================
*/

-- ====================================================================
-- Checking 'silver.crm_cust_info'
-- ====================================================================

-- Check for Nulls or Duplicates in Primary Key
-- Expectation: No Results

--SELECT * FROM bronze.crm_cust_info

SELECT
	cst_id,
	COUNT(*) IDCount
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL
ORDER BY COUNT(*) DESC


-- Check for unwanted spaces
-- Expectation: No Results
SELECT 
*
FROM silver.crm_cust_info
WHERE cst_marital_status!= TRIM(cst_marital_status)

-- Check for consistency
-- Expectation: No results
SELECT DISTINCT
	cst_gndr
FROM silver.crm_cust_info

SELECT * FROM silver.crm_cust_info

-- ====================================================================
-- Checking 'silver.crm_prd_info'
-- ====================================================================

-- Check for Nulls in the Primary Key
-- Expectation: No Results

SELECT
prd_id,
COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 or prd_id IS NULL

-- Check for unwated spaces
-- Expectation: No Results
SELECT prd_nm
FROM silver.crm_prd_info
WHERE TRIM(prd_nm) != prd_nm

-- Check for Nulls or Negative Numbers
-- Expectation: No Results
SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

-- Data Standarization & Consistency
SELECT DISTINCT prd_line
FROM silver.crm_prd_info

-- Check For Invalid Date Orders
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

SELECT *
FROM silver.crm_prd_info

-- ====================================================================
-- Checking 'silver.crm_sales_details'
-- ====================================================================

-- Check for Invalid Dates
--SELECT
--NULLIF(sls_order_dt, 0) AS sls_order_dt,
--LEN(sls_order_dt)
--FROM silver.crm_sales_details
--WHERE LEN(sls_order_dt) <= 0
--OR LEN(sls_order_dt) != 8
--OR sls_order_dt < 19000101
--OR sls_order_dt > 20500101

-- Check for Invalid Order Dates
SELECT
*
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_ship_dt > sls_due_dt

-- Check Data Consistency: Between Sales, Quantity or Price
-- >> Sales = Quantity * Price
-- >> Values must not be NULL, zero or negative

SELECT DISTINCT
sls_sales,
sls_price,
sls_quantity,
	CASE
		WHEN sls_sales IS NULL OR sls_sales <=0 OR sls_sales != ABS(sls_price)*sls_quantity
			THEN ABS(sls_price)*sls_quantity
		ELSE sls_sales
	END AS sls_sales,
	[sls_quantity],
	CASE
		WHEN sls_price IS NULL OR sls_price <= 0
			THEN ABS(sls_sales)/NULLIF(sls_quantity,0)
			ELSE sls_price
	END AS sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_price*sls_quantity
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_quantity IS NULL
OR sls_sales <=0 OR sls_quantity <=0 OR sls_quantity <=0
;
SELECT * FROM silver.crm_sales_details

-- ====================================================================
-- Checking 'silver.erp_cust_az12'
-- ====================================================================

-- Identify Out-of-Range Dates
-- Expectation: Birthdates between 1924-01-01 and Today
SELECT DISTINCT 
    bdate 
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01' 
   OR bdate > GETDATE();

-- Data Standardization & Consistency
SELECT DISTINCT 
    gen 
FROM silver.erp_cust_az12;

-- ====================================================================
-- Checking 'silver.erp_loc_a101'
-- ====================================================================

-- Data Standarization & Consistency
SELECT DISTINCT
cntry
FROM silver.erp_loc_a101
;
SELECT *
FROM silver.erp_loc_a101;

-- ====================================================================
-- Checking 'silver.erp_px_cat_g1v2'
-- ====================================================================

-- Check for unwanted spaces
SELECT
*
FROM bronze.erp_px_cat_g1v2
WHERE cat != TRIM(cat)
OR subcat != TRIM(subcat)
OR maintenance != TRIM(maintenance)
;
-- Data Standarization & Consistency
SELECT DISTINCT
maintenance
FROM bronze.erp_px_cat_g1v2
;
SELECT
*
FROM silver.erp_px_cat_g1v2

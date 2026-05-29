```sql
/*
===============================================================
Quality Checks
===============================================================

Script Purpose:
    This script performs various quality checks for data consistency,
    accuracy, and standardization across the 'silver' schema tables.

    It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after loading the Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================
*/


-- ===============================================================
-- Checking 'silver_crm_cust_info'
-- ===============================================================

-- ---------------------------------------------------------------
-- Check for Nulls or Duplicate Primary Keys
-- Expectation: No duplicate or null customer IDs
-- ---------------------------------------------------------------

SELECT 
    cst_id,
    COUNT(*)
FROM silver_crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1;


-- ---------------------------------------------------------------
-- Check for Unwanted Spaces
-- Expectation: No leading or trailing spaces
-- ---------------------------------------------------------------

SELECT cst_key
FROM silver_crm_cust_info
WHERE cst_key != TRIM(cst_key);

SELECT cst_firstname
FROM silver_crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);

SELECT cst_lastname
FROM silver_crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname);


-- ---------------------------------------------------------------
-- Data Standardization and Consistency
-- Expectation: Consistent marital status and gender values
-- ---------------------------------------------------------------

SELECT DISTINCT cst_marital_status
FROM silver_crm_cust_info;

SELECT DISTINCT cst_gndr
FROM silver_crm_cust_info;



-- ===============================================================
-- Checking 'silver_crm_prd_info'
-- ===============================================================

-- ---------------------------------------------------------------
-- Check for Duplicate or Null Product IDs
-- Expectation: No duplicate or null product IDs
-- ---------------------------------------------------------------

SELECT 
    prd_id,
    COUNT(*)
FROM silver_crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;


-- ---------------------------------------------------------------
-- Check for Unwanted Spaces
-- Expectation: No leading or trailing spaces in product names
-- ---------------------------------------------------------------

SELECT prd_nm
FROM silver_crm_prd_info
WHERE prd_nm != TRIM(prd_nm);


-- ---------------------------------------------------------------
-- Check for Null or Negative Product Costs
-- Expectation: Product cost must be positive and non-null
-- ---------------------------------------------------------------

SELECT prd_cost
FROM silver_crm_prd_info
WHERE prd_cost < 0
   OR prd_cost IS NULL;


-- ---------------------------------------------------------------
-- Data Standardization and Consistency
-- Expectation: Standardized product line values
-- ---------------------------------------------------------------

SELECT DISTINCT prd_line
FROM silver_crm_prd_info;


-- ---------------------------------------------------------------
-- Check for Invalid Date Ranges
-- Expectation: End date must be after start date
-- ---------------------------------------------------------------

SELECT *
FROM silver_crm_prd_info
WHERE prd_end_dt < prd_start_dt;



-- ===============================================================
-- Checking 'silver_crm_sales_details'
-- ===============================================================

-- ---------------------------------------------------------------
-- Check for Invalid Dates
-- Expectation: Order dates must be valid 8-digit dates
-- ---------------------------------------------------------------

SELECT 
    NULLIF(sls_order_dt, 0) AS sls_order_dt
FROM bronze_crm_sales_details
WHERE sls_order_dt <= 0
   OR LENGTH(sls_order_dt) != 8;


-- ---------------------------------------------------------------
-- Check for Invalid Date Orders
-- Expectation: Order date must be before ship and due dates
-- ---------------------------------------------------------------

SELECT *
FROM bronze_crm_sales_details
WHERE sls_order_dt > sls_ship_dt
   OR sls_order_dt > sls_due_dt;


-- ---------------------------------------------------------------
-- Check Sales Calculations and Invalid Numeric Values
-- Expectation: sales = quantity * price
-- ---------------------------------------------------------------

SELECT DISTINCT
    sls_sales,
    sls_quantity,
    sls_price
FROM bronze_crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
   OR sls_sales IS NULL
   OR sls_quantity IS NULL
   OR sls_price IS NULL
   OR sls_sales <= 0
   OR sls_quantity <= 0
   OR sls_price <= 0
ORDER BY sls_sales,
         sls_quantity,
         sls_price;



-- ===============================================================
-- Checking 'silver_erp_cust_az12'
-- ===============================================================

-- ---------------------------------------------------------------
-- Identify Out-of-Range Birthdates
-- Expectation: Birthdates between 1924-01-01 and Today
-- ---------------------------------------------------------------

SELECT DISTINCT bdate
FROM silver_erp_cust_az12
WHERE bdate < '1924-01-01'
   OR bdate > NOW();


-- ---------------------------------------------------------------
-- Data Standardization and Consistency
-- Expectation: Standardized gender values
-- ---------------------------------------------------------------

SELECT DISTINCT gen
FROM silver_erp_cust_az12;



-- ===============================================================
-- Checking 'silver_erp_loc_a101'
-- ===============================================================

-- ---------------------------------------------------------------
-- Data Standardization and Consistency
-- Expectation: Standardized country names
-- ---------------------------------------------------------------

SELECT DISTINCT cntry
FROM silver_erp_loc_a101
ORDER BY cntry;



-- ===============================================================
-- Checking 'silver_erp_px_cat_g1v2'
-- ===============================================================

-- ---------------------------------------------------------------
-- Check for Unwanted Spaces
-- Expectation: No leading or trailing spaces
-- ---------------------------------------------------------------

SELECT *
FROM bronze_erp_px_cat_g1v2
WHERE cat != TRIM(cat)
   OR subcat != TRIM(subcat)
   OR maintenance != TRIM(maintenance);


-- ---------------------------------------------------------------
-- Data Standardization and Consistency
-- Expectation: Standardized category values
-- ---------------------------------------------------------------

SELECT DISTINCT cat
FROM bronze_erp_px_cat_g1v2;

SELECT DISTINCT subcat
FROM bronze_erp_px_cat_g1v2;

SELECT DISTINCT maintenance
FROM bronze_erp_px_cat_g1v2;
```



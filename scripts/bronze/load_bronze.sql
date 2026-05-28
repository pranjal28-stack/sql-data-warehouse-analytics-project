-- =========================================
-- BRONZE LAYER: DATA LOADING
-- =========================================
-- This script documents the loading of raw data into Bronze tables.
-- Data was imported using MySQL Workbench Import Wizard.
-- Equivalent LOAD DATA logic is provided for reference.
-- =========================================

-- LOAD CUSTOMER DATA (CRM)
-- =========================================
TRUNCATE TABLE bronze_crm_cust_info;
LOAD DATA LOCAL INFILE 'datasets/source_crm/cust_info.csv'
INTO TABLE bronze_crm_cust_info
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- =========================================
-- LOAD PRODUCT DATA (CRM)
-- =========================================
TRUNCATE TABLE bronze_crm_prd_info;
LOAD DATA LOCAL INFILE 'datasets/source_crm/prd_info.csv'
INTO TABLE bronze_crm_prd_info
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- =========================================
-- LOAD SALES DATA (CRM)
-- =========================================
TRUNCATE TABLE bronze_crm_sales_details;
LOAD DATA LOCAL INFILE 'datasets/source_crm/sales_details.csv'
INTO TABLE bronze_crm_sales_details
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- =========================================
-- LOAD ERP LOCATION DATA
-- =========================================
TRUNCATE TABLE bronze_erp_loc_a101;
LOAD DATA LOCAL INFILE 'datasets/source_erp/loc_a101.csv'
INTO TABLE bronze_erp_loc_a101
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;



-- =========================================
-- LOAD ERP CUSTOMER DATA (AZ12)
-- =========================================
TRUNCATE TABLE bronze_erp_cust_az12;
LOAD DATA LOCAL INFILE 'datasets/source_erp/cust_az12.csv'
INTO TABLE bronze_erp_cust_az12
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


-- =========================================
-- LOAD ERP CATEGORY DATA
-- =========================================
TRUNCATE TABLE bronze_erp_px_cat_g1v2;
LOAD DATA LOCAL INFILE 'datasets/source_erp/px_cat_g1v.csv'
INTO TABLE bronze_erp_px_cat_g1v
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

/*
===============================================================
DDL Script: Create Silver Tables
===============================================================

Script Purpose:
    This script creates tables in the 'silver' schema, dropping existing tables
    if they already exist.

    Run this script to re-define the DDL structure of 'bronze' tables
===============================================================
*/


use DataWarehouse;
drop table if exists  DataWarehouse.silver_crm_cust_info;
create table DataWarehouse.silver_crm_cust_info(
cst_id int,
cst_key varchar(50),
cst_firstname varchar(50),
cst_lastname varchar(50),
cst_material_status varchar(50),
cst_gndr varchar(50),
cst_create_date date,
dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);
drop table if exists  DataWarehouse.silver_crm_prd_info;
CREATE TABLE DataWarehouse.silver_crm_prd_info (
    prd_id       INT,
    cat_id       VARCHAR(50),
    prd_key      VARCHAR(50),
    prd_nm       VARCHAR(50),
    prd_cost     INT,
    prd_line     VARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt   DATE,
    dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);
drop table if exists  DataWarehouse.silver_crm_sales_details;
CREATE TABLE DataWarehouse.silver_crm_sales_details (
    sls_ord_num  VARCHAR(50),
    sls_prd_key  VARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt INT,
    sls_ship_dt  INT,
    sls_due_dt   INT,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT,
    dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);
drop table if exists DataWarehouse.silver_erp_loc_a101 ;
CREATE TABLE DataWarehouse.silver_erp_loc_a101 (
    cid    VARCHAR(50),
    cntry  VARCHAR(50),
    dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);
drop table if exists DataWarehouse.silver_erp_cust_az12;
CREATE TABLE DataWarehouse.silver_erp_cust_az12 (
    cid    VARCHAR(50),
    bdate  DATE,
    gen    VARCHAR(50),
    dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);
drop table if exists DataWarehouse.silver_erp_px_cat_g1v2 ;
CREATE TABLE DataWarehouse.silver_erp_px_cat_g1v2 (
    id           VARCHAR(50),
    cat          VARCHAR(50),
    subcat       VARCHAR(50),
    maintenance  VARCHAR(50),
    dwh_create_date DATETIME DEFAULT CURRENT_TIMESTAMP
);


/*
==============================================================================
DDL Script: Create Bronze Tables
==============================================================================

Script Purpose:
    This script creates tables in the 'bronze' schema, dropping existing tables
    if they already exist.
    Run this script to re-define the DDL structure of 'bronze' Tables

==============================================================================
*/
-- ==============================
-- CRM TABLES (BRONZE)
-- ==============================

drop table if exists  DataWarehouse.bronze_crm_cust_info;
create table DataWarehouse.bronze_crm_cust_info(
cst_id int,
cst_key varchar(50),
cst_firstname varchar(50),
cst_lastname varchar(50),
cst_material_status varchar(50),
cst_gndr varchar(50),
cst_create_date date
);

drop table if exists  DataWarehouse.bronze_crm_prd_info;
CREATE TABLE DataWarehouse.bronze_crm_prd_info (
    prd_id       INT,
    prd_key      VARCHAR(50),
    prd_nm       VARCHAR(50),
    prd_cost     INT,
    prd_line     VARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt   DATETIME
);

drop table if exists  DataWarehouse.bronze_crm_sales_details;
CREATE TABLE DataWarehouse.bronze_crm_sales_details (
    sls_ord_num  VARCHAR(50),
    sls_prd_key  VARCHAR(50),
    sls_cust_id  INT,
    sls_order_dt INT,
    sls_ship_dt  INT,
    sls_due_dt   INT,
    sls_sales    INT,
    sls_quantity INT,
    sls_price    INT
);

drop table if exists DataWarehouse.bronze_erp_loc_a101 ;
CREATE TABLE DataWarehouse.bronze_erp_loc_a101 (
    cid    VARCHAR(50),
    cntry  VARCHAR(50)
);

drop table if exists DataWarehouse.bronze_erp_cust_az12;
CREATE TABLE DataWarehouse.bronze_erp_cust_az12 (
    cid    VARCHAR(50),
    bdate  DATE,
    gen    VARCHAR(50)
);

drop table if exists DataWarehouse.bronze_erp_px_cat_g1v2 ;
CREATE TABLE DataWarehouse.bronze_erp_px_cat_g1v2 (
    id           VARCHAR(50),
    cat          VARCHAR(50),
    subcat       VARCHAR(50),
    maintenance  VARCHAR(50)
);

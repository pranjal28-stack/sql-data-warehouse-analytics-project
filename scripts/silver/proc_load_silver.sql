/*
===============================================================
Script: Load Silver Layer (Bronze -> Silver)
===============================================================

Script Purpose:
    This script performs the ETL (Extract, Transform, Load) process
    to populate the 'silver' schema tables from the 'bronze' schema.

Actions Performed:
    - Truncates Silver tables.
    - Inserts transformed and cleansed data from Bronze into Silver tables.
    - Applies data cleaning and transformation logic.

Note:
    This project uses MySQL Workbench.
    Stored Procedures are not used in this implementation.

Usage:
    Run this script after loading data into the Bronze layer.
===============================================================
*/

select '>>Truncating Table:silver_crm_cust_info';
truncate table silver_crm_cust_info;
select '>> Inserting Data: silver_crm_cust_info'; 
insert into silver_crm_cust_info(
 cst_id,
 cst_key,
 cst_firstname,
 cst_lastname,
 cst_material_status,
 cst_gndr,
 cst_create_date)
SELECT 
    cst_id,
    cst_key,
    TRIM(cst_firstname) AS cst_firstname,
    TRIM(cst_lastname) AS cst_lastname,
    case when upper(trim(cst_marital_status))='S' then 'SINGLE'
         when upper(trim(cst_marital_status))='M' then 'MARRIED'
         else 'n/a'
	end cst_marital_status,
    case when upper(trim(cst_gndr))='F' then 'FEMALE'
         when upper(trim(cst_gndr))='M' then 'MALE'
         else 'n/a'
	end cst_gndr,
    cst_create_date
FROM (
    SELECT 
        *,
        ROW_NUMBER() OVER (
            PARTITION BY cst_id 
            ORDER BY cst_create_date DESC
        ) AS flag_last
    FROM bronze_crm_cust_info
    WHERE cst_id IS NOT NULL
) 
WHERE flag_last = 1;



select '>>Truncating Table:silver_crm_prd_info';
truncate table silver_crm_prd_info;
select '>> Inserting Data: silver_crm_prd_info'; 
insert into silver_crm_prd_info(
    prd_id,
    cat_id,
    prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt)
 SELECT 
    prd_id,

    REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') AS cat_id,

    SUBSTRING(prd_key, 7, LENGTH(prd_key)) AS prd_key,

    prd_nm,

    IFNULL(prd_cost, 0) AS prd_cost,

    CASE UPPER(TRIM(prd_line))
        WHEN 'M' THEN 'Mountain'
        WHEN 'R' THEN 'Road'
        WHEN 'S' THEN 'Other Sales'
        WHEN 'T' THEN 'Touring'
        ELSE 'n/a'
    END AS prd_line,

    Convert(prd_start_dt, DATE) AS prd_start_dt,

    Convert(
        DATE_SUB(
            LEAD(prd_start_dt) OVER (
                PARTITION BY prd_key 
                ORDER BY prd_start_dt
            ),
            INTERVAL 1 DAY
        ) ,DATE
    ) AS prd_end_dt

FROM bronze_crm_prd_info;


select '>>Truncating Table:silver_crm_sales_details';
truncate table silver_crm_sales_details;
select '>> Inserting Data: silver_crm_sales_details'; 
insert into DataWarehouse.silver_crm_sales_details (
    sls_ord_num  ,
    sls_prd_key  ,
    sls_cust_id  ,
    sls_order_dt ,
    sls_ship_dt  ,
    sls_due_dt   ,
    sls_sales    ,
    sls_quantity ,
    sls_price    
    )
select 
sls_ord_num,
sls_prd_key,
sls_cust_id,
case when sls_order_dt=0 or length(sls_order_dt)!=8 then null
     else str_to_date(sls_order_dt, '%Y%m%d')
end as sls_order_dt,
case when sls_ship_dt=0 or length(sls_ship_dt)!=8 then null
     else str_to_date(sls_ship_dt, '%Y%m%d')
end as sls_ship_dt,
case when sls_due_dt=0 or length(sls_due_dt)!=8 then null
     else str_to_date(sls_due_dt, '%Y%m%d')
end as sls_due_dt,
case when sls_sales is null or sls_sales <=0 or sls_sales != sls_quantity * abs(sls_price)
          then sls_quantity* abs(sls_price)
     else sls_sales
end as sls_sales,
sls_quantity,
case when sls_price is null or sls_price<=0
          then sls_sales/nullif(sls_quantity,0)
	else sls_price
end as
sls_price
from bronze_crm_sales_details;





select '>>Truncating Table:silver_erp_cust_az12';
truncate table silver_erp_cust_az12;
select '>> Inserting Data: silver_erp_cust_az12'; 
insert into DataWarehouse.silver_erp_cust_az12 (
    cid    ,
    bdate  ,
    gen   )
select 
case when cid like 'NAS%' then substring(cid,4, length(cid))
	else cid
end as
cid,
case when bdate>now() then null
     else bdate
end as
bdate,
case when upper(trim(gen)) in ('F','Female') then 'Female'
     when upper(trim(gen)) in ('M', 'Male') then 'Male'
     else 'N/A'
end as
gen
from bronze_erp_cust_az12;





select '>>Truncating Table:silver_erp_loc_a101';
truncate table silver_erp_loc_a101;
select '>> Inserting Data: silver_erp_loc_a101'; 
insert into DataWarehouse.silver_erp_loc_a101 (
    cid ,
    cntry  )
select 
replace(cid, '-', '') cid,
case when trim(cntry) = 'DE' then 'Germany'
     when trim(cntry) in ('US','USA') then 'United States'
     when trim(cntry) = '' or cntry is null then 'N/A'
     else trim(cntry)
end as
cntry
from bronze_erp_loc_a101;

-- where replace(cid, '-', '') cid not in (select cst_key from silver_crm_cust_info; to check that all cid  data is same or else the ones not in it will be deleted.




select '>>Truncating Table:silver_erp_px_cat_g1v2';
truncate table silver_erp_px_cat_g1v2;
select '>> Inserting Data: silver_erp_px_cat_g1v2'; 
insert into silver_erp_px_cat_g1v2
(id,cat,subcat, maintenance)
select 
id,
cat,
subcat,
maintenance
from bronze_erp_px_cat_g1v2;




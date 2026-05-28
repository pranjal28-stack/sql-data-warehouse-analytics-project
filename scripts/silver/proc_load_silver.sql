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

-- check for nulls and duplicates in primary key
-- 
select cst_id,count(*)
from silver_crm_cust_info
group by cst_id
having count(*)>1;

-- check for unwanted spaces
select cst_key from silver_crm_cust_info
where cst_key!= trim(cst_key);
select cst_firstname from silver_crm_cust_info
where cst_firstname!= trim(cst_firstname);
select cst_lastname from silver_crm_cust_info
where cst_lastname!= trim(cst_lastname);


-- Data Standardization and Consistency
select distinct cst_marital_status
from silver_crm_cust_info;
select distinct cst_gndr
from silver_crm_cust_info;



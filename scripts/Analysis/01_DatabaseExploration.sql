-- explore all the objects in the database
select * from information_schema.tables;

-- explore all the columns in the database
select * from information_schema.columns
where table_name = 'gold_dim_customers';

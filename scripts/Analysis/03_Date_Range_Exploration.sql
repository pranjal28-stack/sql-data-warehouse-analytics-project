-- find the date of the first and the last order
-- how many years of sales are available
select 
min(order_date) as first_order_date,
max(order_date) as last_order_date,
timestampdiff(year,min(order_date), max(order_date)) as order_range_years
from gold_fact_sales;

-- find the youngest and oldest customers
select
min(birthdate) as oldest_birthdate,
timestampdiff(year, min(birthdate),now()) as oldest_age,
max(birthdate) as youngest_birthdate,
timestampdiff(year, max(birthdate),now()) as youngest_age
from gold_dim_customers;

-- which 5 products generate the highest revenue
select 
p.product_name,
sum(f.sales_amount) as total_revenue
from gold_fact_sales f
left join gold_dim_products p
on p.product_key = f.product_key
group by p.product_name
order by total_revenue desc
limit 5;

select * from
(select 
p.product_name,
sum(f.sales_amount) as total_revenue,
row_number() over (order by sum(f.sales_amount) desc) as rank_products
from gold_fact_sales f
left join gold_dim_products p
on p.product_key = f.product_key
group by p.product_name)t
where rank_products<=5;


-- what are the 5 worst-performing products in terms of sales
select 
p.product_name,
sum(f.sales_amount) as total_revenue
from gold_fact_sales f
left join gold_dim_products p
on p.product_key = f.product_key
group by p.product_name
order by total_revenue 
limit 5;

--  find the top 10 customers who have generated the highest revenue
select
c.customer_key,
c.first_name,
c.last_name,
sum(f.sales_amount) as total_revenue
from gold_fact_sales f
left join gold_dim_customers c
on c.customer_key= f.customer_key
group by
c.customer_key,
c.first_name,
c.last_name
order by total_revenue desc
limit 10;

-- the three customers witht he fewest orders placed
select
c.customer_key,
c.first_name,
c.last_name,
count(distinct order_number) as total_orders
from gold_fact_sales f
left join gold_dim_customers c
on c.customer_key= f.customer_key
group by
c.customer_key,
c.first_name,
c.last_name
order by total_orders 
limit 3;

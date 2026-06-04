-- find the total sales
select sum(sales_amount) as total_sales from gold_fact_sales;
-- find how many items are sold
select sum(quantity) as total_quantity from gold_fact_sales;
-- find the average selling price
select avg(price) as avg_selling_price from gold_fact_sales;
-- find the total number of orders
select count(order_number) as total_orders from gold_fact_sales;
select count( distinct order_number) as total_orders from gold_fact_sales;
-- find the total number of products
select count(product_key) as total_products from gold_dim_products;
select count( distinct product_name) as total_products from gold_dim_products;
-- find the total number of customers
select count(customer_key) as total_customers from gold_dim_customers;

-- find the total number of customers that placed an order
select count(distinct customer_key) as total_customers from gold_fact_sales;


-- generate a key metrics that shows all the key metrics of the business
select 'Total Sales' as measure_name, sum(sales_amount) as measure_value from gold_fact_sales
union all
select 'Total Quantity' as measure_name, sum(quantity) as measure_value from gold_fact_sales
union all
select 'Average Price' as measure_name, avg(price) as measure_value from gold_fact_sales
union all
select 'Total Nr. Orders', count( distinct order_number) from gold_fact_sales
union all
select 'Total Nr. Products', count( distinct product_name)  from gold_dim_products
union all
select 'Total Nr. Customers', count(customer_key) from gold_dim_customers;

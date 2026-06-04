-- explore all counttries our customers come from
select distinct country from gold_dim_customers;

-- explore all the categories 'The Major Dicision'
select distinct category, subcategory, product_name from gold_dim_products order by 1,2,3;
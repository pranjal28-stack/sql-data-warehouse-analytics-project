-- calculate the total sales per month
-- and the running total sales over time


SELECT
    order_month,
    total_sales,
    SUM(total_sales) OVER (partition by order_date  ORDER BY order_date) AS running_total_sales,
    avg(avg_price) OVER ( partition by order_date order BY order_date) AS moving_average
FROM
(
    SELECT
        MIN(order_date) AS order_date,
        DATE_FORMAT(MIN(order_date), '%Y-%b') AS order_month,
        SUM(sales_amount) AS total_sales,
        avg(price) as avg_price
    FROM gold_fact_sales
    WHERE order_date IS NOT NULL
    GROUP BY YEAR(order_date), month(order_date)
) t;

WITH fact_sales_orders__source AS(
  SELECT *
  FROM  `vit-lam-data.wide_world_importers.sales__orders`
)
, 
fact_sales_orders__rename_column AS(
  SELECT 
   order_id as sales_order_key
   ,customer_id as customer_key
  FROM fact_sales_orders__source
)
,
fact_sales_orders_convert_type AS(
  SELECT
  CAST (sales_order_key as Integer) as sales_order_key
  , CAST (customer_key as Integer) as customer_key
  FROM fact_sales_orders__rename_column
)

SELECT
sales_order_key
,customer_key
FROM fact_sales_orders_convert_type
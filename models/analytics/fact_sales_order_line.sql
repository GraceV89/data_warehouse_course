WITH fact_sales_order_line__source AS(
  SELECT *
  FROM  `vit-lam-data.wide_world_importers.sales__order_lines`
)
, 
fact_sales_order_line__rename_column AS(
  SELECT 
   order_line_id as sales_order_line_key
   ,order_id as sales_order_key
   ,stock_item_id as product_key
   ,quantity as quantity
   ,unit_price as unit_price
   ,quantity  * unit_price  as gross_amount
   
FROM fact_sales_order_line__source
)
,
fact_sales_order_line__convert_type AS(
  SELECT 
   CAST(sales_order_line_key as Integer) as sales_order_line_key
   ,CAST(sales_order_key as Integer) as sales_order_key
   ,CAST( product_key as Integer) as product_key
   ,CAST(quantity as Integer) as quantity
   ,CAST(unit_price as Numeric) as unit_price
   ,CAST(quantity as Integer) * CAST(unit_price as Numeric) as gross_amount

   FROM fact_sales_order_line__rename_column
)

SELECT 
   fact_line.sales_order_line_key
   ,fact_line.sales_order_key
   ,fact_line.product_key
   ,fact_header.customer_key
   ,fact_line.quantity
   ,fact_line.unit_price
   ,quantity * unit_price as gross_amount
   
FROM fact_sales_order_line__convert_type as fact_line

LEFT JOIN {{ref('stg_fact_sales_orders')}} as fact_header
ON fact_line.sales_order_key =fact_header.sales_order_key



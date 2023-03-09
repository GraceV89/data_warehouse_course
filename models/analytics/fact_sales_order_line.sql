WITH fact_sales_order_line__source AS(
  SELECT *
  FROM  `vit-lam-data.wide_world_importers.sales__order_lines`
)
, 
fact_sales_order_line__rename_column AS(
  SELECT 
   order_line_id as sales_order_line_key
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
   ,CAST( product_key as Integer) as product_key
   ,CAST(quantity as Integer) as quantity
   ,CAST(unit_price as Numeric) as unit_price
   ,CAST(quantity as Integer) * CAST(unit_price as Numeric) as gross_amount

   FROM fact_sales_order_line__rename_column
)

SELECT 
   sales_order_line_key
   ,product_key
   ,quantity
   ,unit_price
   ,quantity * unit_price as gross_amount
   
FROM fact_sales_order_line__convert_type

SELECT 
   CAST(order_line_id as Integer) as sales_order_line_key,
   CAST(quantity as Integer) as quantity,
   CAST(unit_price as Numeric) as unit_price,
   CAST(quantity as Integer) * CAST(unit_price as Numeric) AS gross_amount,
   stock_item_id as product_key
FROM `vit-lam-data.wide_world_importers.sales__order_lines`

WITH 
dim_procduct__source AS(
SELECT *
FROM `vit-lam-data.wide_world_importers.warehouse__stock_items`
)

, 
dim_product__rename_column AS(
SELECT 
stock_item_id   as product_key 
,stock_item_name as product_name 
,brand as brand_name
 FROM dim_procduct__source  
)

,dim_product__cast_type AS(
SELECT 
CAST(product_key AS INTEGER)  as product_key 
,CAST( product_name AS STRING) as product_name 
,CAST(brand_name AS STRING) as brand_name
 FROM dim_product__rename_column 
)

SELECT
product_key 
,product_name 
,brand_name
FROM dim_product__cast_type
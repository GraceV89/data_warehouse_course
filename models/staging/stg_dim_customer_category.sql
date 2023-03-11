WITH dim_sales__customer_category_source AS (
  SELECT
  * 
  FROM `vit-lam-data.wide_world_importers.sales__customer_categories`
)
,

dim_sales__customer_category_rename AS (
  SELECT
  customer_category_id AS customer_category_key
  ,customer_category_name AS customer_category_name
  FROM dim_sales__customer_category_source
)
,

dim_sales__customer_category_convert_type AS (
  SELECT
  CAST (customer_category_key AS Integer) as customer_category_key
  ,CAST(customer_category_name AS String) as customer_category_name 
  FROM dim_sales__customer_category_rename

)

SELECT
customer_category_key
,customer_category_name

FROM dim_sales__customer_category_convert_type AS dim_sales__customer_category

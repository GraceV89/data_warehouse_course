WITH dim_customer__source AS(
  SELECT 
  *
  FROM `vit-lam-data.wide_world_importers.sales__customers`
)
,
dim_customer__rename_column AS(
  SELECT
  customer_id AS customer_key
  ,customer_name
  ,customer_category_id AS customer_category_key
  ,buying_group_id AS buying_group_key
  FROM dim_customer__source
)
,
dim_customer__convert_type AS(
  SELECT
  CAST (customer_key AS Integer) AS customer_key
  ,CAST (customer_name AS STRING)AS customer_name
  ,CAST (customer_category_key AS Integer) AS customer_category_key
  ,CAST (buying_group_key AS Integer)AS buying_group_key
  FROM dim_customer__rename_column 
)

SELECT 
dim_customer.customer_key
,dim_customer.customer_name
,dim_customer_category.customer_category_key
,dim_customer_category.customer_category_name
,dim_sales_buying_group.buying_group_key
,dim_sales_buying_group.buying_group_name
FROM dim_customer__convert_type AS dim_customer
LEFT JOIN {{ref('stg_dim_customer_category')}} AS dim_customer_category
    ON dim_customer.customer_category_key=dim_customer_category.customer_category_key
LEFT JOIN {{ref('stg_dim_sales_buying_group')}} AS dim_sales_buying_group
    ON dim_customer.buying_group_key=dim_sales_buying_group.buying_group_key



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
      ,is_on_credit_hold AS is_on_credit_hold_boolean
  FROM dim_customer__source
)

,
dim_customer__convert_type AS(
  SELECT
    CAST (customer_key AS Integer) AS customer_key
    ,CAST (customer_name AS STRING)AS customer_name
    ,CAST (customer_category_key AS Integer) AS customer_category_key
    ,CAST (buying_group_key AS Integer)AS buying_group_key
    ,CAST (is_on_credit_hold_boolean AS Boolean) AS is_on_credit_hold_boolean    
  FROM dim_customer__rename_column 
)

,
dim_customer_boolean AS (
  SELECT
  *
    ,CASE 
      WHEN is_on_credit_hold_boolean IS TRUE THEN 'On Credit Hold'
      WHEN is_on_credit_hold_boolean IS FALSE THEN 'NOT On Credit Hold'
      WHEN is_on_credit_hold_boolean IS NULL THEN 'Undefine'
      ELSE 'Invalid' END
    AS is_on_credit_hold
  FROM dim_customer__convert_type
)

SELECT 
    dim_customer.customer_key
    ,dim_customer.customer_name
    ,dim_customer_category.customer_category_key

    , COALESCE(dim_customer_category.customer_category_name, 'Invalid') AS customer_category_name 

    ,dim_buying_group.buying_group_key

    , COALESCE(dim_buying_group.buying_group_name, 'Invalid') AS buying_group_name

    ,dim_customer.is_on_credit_hold

FROM dim_customer_boolean AS dim_customer

  LEFT JOIN {{ref('stg_dim_customer_category')}} AS dim_customer_category
      ON dim_customer.customer_category_key=dim_customer_category.customer_category_key
  LEFT JOIN {{ref('stg_dim_sales_buying_group')}} AS dim_buying_group
      ON dim_customer.buying_group_key=dim_buying_group.buying_group_key



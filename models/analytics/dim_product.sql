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
    ,supplier_id as supplier_key
    ,is_chiller_stock as is_chiller_stock_boolean
  FROM dim_procduct__source  
)

,dim_product__cast_type AS(
  SELECT 
    CAST(product_key AS INTEGER)  as product_key 
    ,CAST( product_name AS STRING) as product_name 
    ,CAST(brand_name AS STRING) as brand_name
    ,CAST(supplier_key AS INTEGER) as supplier_key
    ,CAST(is_chiller_stock_boolean AS BOOLEAN) as is_chiller_stock_boolean
  FROM dim_product__rename_column 
)

,dim_product_convert_boolean AS(
   SELECT
      *
      ,CASE 
        When is_chiller_stock_boolean IS  TRUE THEN 'Chiller Stock'
        When is_chiller_stock_boolean IS FALSE THEN 'NOT Chiller Stock'
        When is_chiller_stock_boolean IS NULL THEN 'Undefined'
        ELSE 'Invalid' END 
      AS is_chiller_stock

    FROM dim_product__cast_type
)

  SELECT
    dim_product.product_key 
    ,dim_product.product_name 
    ,dim_product.supplier_key
    ,COALESCE(dim_supplier.supplier_name, 'Invalid') AS supplier_name
    ,COALESCE(dim_product.brand_name, 'Undefined') AS brand_name
    ,dim_product.is_chiller_stock
  FROM dim_product_convert_boolean as dim_product
LEFT JOIN {{ref('dim_supplier')}} as dim_supplier
  ON dim_product.supplier_key=dim_supplier.supplier_key
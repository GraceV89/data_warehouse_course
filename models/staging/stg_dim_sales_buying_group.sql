WITH dim_sales__buying_group_source AS (
  SELECT
  * 
  FROM `vit-lam-data.wide_world_importers.sales__buying_groups`
)
,

dim_sales__buying_group_rename AS (
  SELECT
  buying_group_id AS buying_group_key
  ,buying_group_name AS buying_group_name
  FROM
  dim_sales__buying_group_source 
)
,

dim_sales__buying_group_convert_type AS (
  SELECT
  CAST (buying_group_key AS Integer) as buying_group_key
  ,CAST(buying_group_name AS String) as buying_group_name 
  FROM dim_sales__buying_group_rename
)

SELECT
buying_group_key
,buying_group_name

FROM dim_sales__buying_group_convert_type AS dim_buying_group_rename
WITH dim_person__source AS(
    SELECT 
      *
    FROM `vit-lam-data.wide_world_importers.application__people`
)
,

dim_person__rename_column AS(
 SELECT
    person_id AS person_key
    ,full_name AS full_name
 FROM dim_person__source
)
,

dim_person__convert_type AS(
  SELECT
      CAST(person_key AS INTEGER) AS person_key
      ,CAST (full_name AS STRING) AS full_name
  FROM dim_person__rename_column
)

,
dim_person_add_undefined_row AS (
  SELECT
    person_key
    ,full_name
  FROM dim_person__convert_type 

  UNION ALL
  SELECT
      0 AS person_key
      ,'Undefine' AS full_name  
      -- khong co FROM
)

SELECT
    person_key
   ,full_name
FROM dim_person_add_undefined_row





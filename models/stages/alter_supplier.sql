{{
    config(
        materialized='table'
    )
}}

create or replace table suppliers as select *,current_timestamp as updated_time from snowflake_sample_data.tpch_sf1.supplier
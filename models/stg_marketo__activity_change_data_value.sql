with base as (

    select *
    from {{ var('activity_change_data_value') }}

), fields as (

    select 
        id as activity_id,
        activity_date,
        lead_id,
        new_value,
        old_value,
        primary_attribute_value,
        primary_attribute_value_id
    from base

)

select *
from fields
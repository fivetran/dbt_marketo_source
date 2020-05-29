with base as (

    select *
    from {{ var('activity_change_data_value') }}

), fields as (

    select 
        activity_date as activity_timestamp,
        activity_type_id,
        api_method_name,
        campaign_id,
        id as activity_id,
        lead_id,
        modifying_user as modifying_user_id,
        new_value,
        old_value,
        primary_attribute_value,
        primary_attribute_value_id,
        reason as change_reason,
        request_id,
        source as change_source
    from base

)

select *
from fields
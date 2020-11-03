with base as (

    select *
    from {{ var('activity_delete_lead') }}

), fields as (

    select
        id as activity_id,
        _fivetran_synced,
        activity_date as activity_timestamp,
        activity_type_id,
        campaign as campaign_name,
        campaign_id,
        lead_id,
        primary_attribute_value,
        primary_attribute_value_id
    from base

)

select *
from fields


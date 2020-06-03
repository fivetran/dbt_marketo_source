with base as (

    select *
    from {{ source('marketo','activity_merge_leads') }}

), fields as (

    select
        id as activity_id,
        _fivetran_synced,
        activity_date as activity_timestamp,
        activity_type_id,
        campaign_id,
        lead_id,
        master_updated,
        trim(trim(merge_ids,']'),'[') as merged_lead_id,
        merge_source,
        merged_in_sales,
        primary_attribute_value,
        primary_attribute_value_id
    from base

)

select *
from fields
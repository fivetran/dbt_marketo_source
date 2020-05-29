with base as (

    select *
    from {{ var('activity_email_delivered') }}

), fields as (

    select 
        activity_date as activity_timestamp,
        activity_type_id,
        campaign_id,
        campaign_run_id,
        choice_number,
        email_template_id,
        id as activity_id, 
        lead_id,
        primary_attribute_value,
        primary_attribute_value_id,
        step_id
    from base

), surrogate as (

    select 
        *,
        {{ dbt_utils.surrogate_key(['campaign_id','campaign_run_id','lead_id']) }} as email_send_id
    from fields

)

select *
from surrogate
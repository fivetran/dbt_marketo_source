with base as (

    select *
    from {{ var('activity_unsubscribe_email') }}

), fields as (

    select 	
        activity_date as activity_timestamp,
        activity_type_id,
        campaign_id,
        campaign_run_id,
        client_ip_address,
        email_template_id,
        form_fields,
        id as activity_id,
        lead_id,
        primary_attribute_value,
        primary_attribute_value_id,
        query_parameters,
        referrer_url,
        user_agent,
        webform_id,
        webpage_id
    from base

), surrogate as (

    select 
        *,
        {{ dbt_utils.surrogate_key(['campaign_id','campaign_run_id','lead_id']) }} as email_send_id
    from fields

)

select *
from surrogate
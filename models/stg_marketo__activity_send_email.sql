with base as (

    select *
    from {{ ref('stg_marketo__activity_send_email_tmp') }}

), macro as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_marketo__activity_send_email_tmp')),
                staging_columns=get_activity_send_email_columns()
            )
        }}
    from base

), fields as (

    select 
        cast(activity_date as {{ dbt.type_timestamp() }}) as activity_timestamp,
        activity_type_id,
        action_result,
        campaign_id,
        campaign_run_id,
        choice_number,
        email_template_id,
        id as activity_id,
        lead_id,
        primary_attribute_value,
        primary_attribute_value_id,
        step_id

        {{ fivetran_utils.fill_pass_through_columns('marketo__activity_send_email_passthrough_columns') }}

    from macro

), surrogate as (

    select 
        *,
        {{ dbt_utils.generate_surrogate_key(['primary_attribute_value_id','campaign_id','campaign_run_id','lead_id']) }} as email_send_id
    from fields

)

select *
from surrogate



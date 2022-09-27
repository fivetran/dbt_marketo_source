{{ config(enabled=var('marketo__enable_campaigns', False)) }}

with base as (

    select *
    from {{ ref('stg_marketo__campaign_tmp') }}

), macro as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_marketo__campaign_tmp')),
                staging_columns=get_campaign_columns()
            )
        }}
    from base

), fields as (

    select 
        active as is_active,
        created_at as created_timestamp,
        description,
        id as campaign_id,
        name as campaign_name,
        program_id,
        program_name,
        type as campaign_type,
        updated_at as updated_timestamp,
        workspace_name
    from macro

)

select *
from fields


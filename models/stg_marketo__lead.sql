with base as (

    select *
    from {{ ref('stg_marketo__lead_tmp') }}

), macro as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_marketo__lead_tmp')),
                staging_columns=get_lead_columns()
            )
        }}
    from base

), leads as (

    select
        id as lead_id,
        created_at as created_timestamp,
        updated_at as updated_timestamp,
        email,
        first_name,
        last_name

        {{ fivetran_utils.fill_pass_through_columns('marketo__lead_passthrough_columns') }}

    from macro
)

select *
from leads
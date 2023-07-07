with base as (

    select *
    from {{ ref('stg_marketo__lead_tmp') }}

), leads as (

    select
        id as lead_id,
        created_at as created_timestamp,
        updated_at as updated_timestamp,
        email,
        first_name,
        last_name

        {{ fivetran_utils.fill_pass_through_columns('marketo__lead_passthrough_columns') }}

    from base
)

select *
from leads
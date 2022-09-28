with base as (

    select *
    from {{ ref('stg_marketo__lead_tmp') }}

), leads as (

    select
        id as lead_id,
        created_at as created_timestamp,
        updated_at as updated_timestamp,
        {{ dbt_utils.star(from=ref('stg_marketo__lead_tmp'), except=['id', 'created_at', 'updated_at']) }}
    from base
)

select *
from leads
with base as (

    select *
    from {{ ref('stg_marketo__lead_adapter') }}

), fields as (

    select
        id as lead_id,
        {{ dbt_utils.star(from=ref('stg_marketo__lead_adapter'), except=['id']) }}
    from base

)

select *
from fields

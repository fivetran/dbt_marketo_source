with base as (

    select *
    from {{ var('lead_describe') }}

), fields as (

    select
        id as lead_describe_id,
        restname 
    from base

)

select *
from fields
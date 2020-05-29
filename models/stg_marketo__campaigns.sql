with base as (

    select *
    from {{ var('campaign') }}

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
    from base

)

select *
from fields
with base as (

    select *
    from {{ var('program') }}

), fields as (

    select
        id as program_id,
        channel,
        created_at as created_timestamp,
        description,
        end_date as end_timestamp,
        name as program_name,
        sfdc_id,
        sfdc_name,
        start_date as start_timestamp,
        status as program_status,
        type as program_type,
        updated_at as updated_timestamp,
        url,
        workspace
    from base
    
)

select *
from fields
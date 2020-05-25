with base as (

    select *
    from {{ var('email_template_history') }}

), fields as (

    select 
        id as email_template_id,
        updated_at as updated_timestamp,
        created_at as created_timestamp,
        description,
        operational as is_operational
    from base

), versions as (

    select  
        *,
        row_number() over (partition by email_template_id order by updated_timestamp) as inferred_version,
        count(*) over (partition by email_template_id) as total_count_of_versions
    from fields

), valid as (

    select 
        *,
        case
            when inferred_version = 1 then created_timestamp
            else updated_timestamp
        end as valid_from,
        lead(updated_timestamp) over (partition by email_template_id order by updated_timestamp) as valid_to,
        inferred_version = total_count_of_versions as is_most_recent_version
    from versions

), surrogate_key as (

    select 
        *,
        {{ dbt_utils.surrogate_key(['email_template_id','inferred_version'] )}} as email_template_history_id
    from valid

)

select *
from surrogate_key

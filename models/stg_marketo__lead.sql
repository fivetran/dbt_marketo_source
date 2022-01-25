with leads as (

    select *
    from {{ ref('stg_marketo__lead_base') }}

), deleted_leads as (

    select *
    from {{ ref('stg_marketo__activity_delete_lead') }}

), merged_leads as (

    select 
        cast(lead_id as {{ dbt_utils.type_int() }}) as lead_id,
        -- in case there are multiple lead IDS merged at once, insert a space betweeen the comma and the following ID
        replace( cast(merged_lead_id as {{ dbt_utils.type_string() }}), ',', ', ') as merged_lead_id

    from {{ ref('stg_marketo__activity_merge_leads') }}

), unique_merges as (

    select 
        cast(lead_id as {{ dbt_utils.type_int() }}) as lead_id,
        {{ fivetran_utils.string_agg('distinct merged_lead_id', "', '") }} as merged_into_lead_id

    from merged_leads
    group by lead_id 

), joined as (

    select 
        leads.*,
        case when deleted_leads.lead_id is not null then True else False end as is_deleted,
        unique_merges.merged_into_lead_id,
        case when unique_merges.merged_into_lead_id is not null then True else False end as is_merged
    from leads
    left join deleted_leads on leads.lead_id = deleted_leads.lead_id
    left join unique_merges on leads.lead_id = unique_merges.lead_id
        
)

select *
from joined
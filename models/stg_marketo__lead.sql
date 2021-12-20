with leads as (

    select *
    from {{ ref('stg_marketo__lead_base') }}

), deleted_leads as (

    select *
    from {{ ref('stg_marketo__activity_delete_lead') }}

), merged_leads as (

    select *
    from {{ ref('stg_marketo__activity_merge_leads') }}

), unique_merges as (

    select 
        {% if target.type == 'bigquery' %}
        cast(merged_lead_id as INT64) as lead_id,
        cast(lead_id as string) as merged_into_lead_id
        {% else %}
        try_cast(merged_lead_id as integer) as lead_id,
        cast(lead_id as varchar) as merged_into_lead_id
        {% endif %}
    from merged_leads

), joined as (

    select 
        leads.*,
        case when deleted_leads.lead_id is not null then True else False end as is_deleted,
        unique_merges.merged_into_lead_id,
        case when unique_merges.merged_into_lead_id is not null then True else False end as is_merged
    from leads
    left join deleted_leads using (lead_id)
    left join unique_merges using (lead_id)
        
)

select *
from joined

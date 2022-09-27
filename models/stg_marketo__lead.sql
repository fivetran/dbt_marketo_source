with leads as (

    select *
    from {{ ref('stg_marketo__lead_base') }}

--If you use activity_delete_lead tags this will be included, if not it will be ignored.
{% if var('marketo__activity_delete_lead_enabled', True) %}
), deleted_leads as (

    select *
    from {{ ref('stg_marketo__activity_delete_lead') }}
{% endif %}

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

        --If you use activity_delete_lead tags this will be included, if not it will be ignored.
        {% if var('marketo__activity_delete_lead_enabled', True) %}
        case when deleted_leads.lead_id is not null then True else False end as is_deleted,
        {% endif %}

        unique_merges.merged_into_lead_id,
        case when unique_merges.merged_into_lead_id is not null then True else False end as is_merged
    from leads

    --If you use activity_delete_lead tags this will be included, if not it will be ignored.
    {% if var('marketo__activity_delete_lead_enabled', True) %}
    left join deleted_leads on leads.lead_id = deleted_leads.lead_id
    {% endif %}

    left join unique_merges on leads.lead_id = unique_merges.lead_id
        
)

select *
from joined
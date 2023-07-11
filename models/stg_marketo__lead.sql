with base as (

    select *
    from {{ ref('stg_marketo__lead_tmp') }}

), macro as (

    select
        {{
            fivetran_utils.fill_staging_columns(
                source_columns=adapter.get_columns_in_relation(ref('stg_marketo__lead_tmp')),
                staging_columns=get_lead_columns()
            )
        }}
        -- This will check if there are non-default columns to bring in
        {% set default_cols = ['id', 'created_at', 'updated_at', 'email', 'first_name', 'last_name'] %}
        {% set new_cols = dbt_utils.star(from=ref('stg_marketo__lead_tmp'), except=default_cols) %}
        {% if new_cols != '/* no columns returned from star() macro */' %}
            ,{{ new_cols }} 
        {% endif %}
        
    from base

)

select *
from macro
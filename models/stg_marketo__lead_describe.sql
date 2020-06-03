with base as (

    select *
    from {{ var('lead_describe') }}

), fields as (

    select
        data_type,
        display_name,
        id as lead_describe_id,
        length as field_max_length,
        restname as rest_name,
        restread_only as is_rest_readonly,
        soapname as soap_name,
        soapread_only as is_soap_readonly
    from base

), regex as (

    select 
        *,
        case
            when rest_name like '%\\_\\_c%' then lower(rest_name)
            else ltrim(lower(regexp_replace(rest_name, '[A-Z]','_\\0')),'_')
        end as rest_name_xf
    from fields

)

select *
from regex
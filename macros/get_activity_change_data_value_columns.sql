{% macro get_activity_change_data_value_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "activity_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "activity_type_id", "datatype": dbt_utils.type_int()},
    {"name": "api_method_name", "datatype": dbt_utils.type_string()},
    {"name": "campaign_id", "datatype": dbt_utils.type_int()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "lead_id", "datatype": dbt_utils.type_int()},
    {"name": "modifying_user", "datatype": dbt_utils.type_string()},
    {"name": "new_value", "datatype": dbt_utils.type_string()},
    {"name": "old_value", "datatype": dbt_utils.type_string()},
    {"name": "primary_attribute_value", "datatype": dbt_utils.type_string()},
    {"name": "primary_attribute_value_id", "datatype": dbt_utils.type_int()},
    {"name": "reason", "datatype": dbt_utils.type_string()},
    {"name": "request_id", "datatype": dbt_utils.type_string()},
    {"name": "source", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}

{% macro get_activity_click_email_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt_utils.type_timestamp()},
    {"name": "activity_date", "datatype": dbt_utils.type_timestamp()},
    {"name": "activity_type_id", "datatype": dbt_utils.type_int()},
    {"name": "campaign_id", "datatype": dbt_utils.type_int()},
    {"name": "campaign_run_id", "datatype": dbt_utils.type_int()},
    {"name": "choice_number", "datatype": dbt_utils.type_int()},
    {"name": "device", "datatype": dbt_utils.type_string()},
    {"name": "email_template_id", "datatype": dbt_utils.type_int()},
    {"name": "id", "datatype": dbt_utils.type_string()},
    {"name": "is_mobile_device", "datatype": "boolean"},
    {"name": "lead_id", "datatype": dbt_utils.type_int()},
    {"name": "link", "datatype": dbt_utils.type_string()},
    {"name": "link_id", "datatype": dbt_utils.type_string()},
    {"name": "platform", "datatype": dbt_utils.type_string()},
    {"name": "primary_attribute_value", "datatype": dbt_utils.type_string()},
    {"name": "primary_attribute_value_id", "datatype": dbt_utils.type_int()},
    {"name": "step_id", "datatype": dbt_utils.type_int()},
    {"name": "test_variant", "datatype": dbt_utils.type_int()},
    {"name": "user_agent", "datatype": dbt_utils.type_string()}
] %}

{{ return(columns) }}

{% endmacro %}

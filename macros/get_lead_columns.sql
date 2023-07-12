{% macro get_lead_columns() %}

{% set columns = [
    {"name": "_fivetran_synced", "datatype": dbt.type_timestamp()},
    {"name": "created_at", "datatype": dbt.type_timestamp(), "alias": "created_timestamp"},
    {"name": "email", "datatype": dbt.type_string()},
    {"name": "first_name", "datatype": dbt.type_string()},
    {"name": "id", "datatype": dbt.type_int(), "alias": "lead_id"},
    {"name": "last_name", "datatype": dbt.type_string()},
    {"name": "updated_at", "datatype": dbt.type_timestamp(), "alias": "updated_timestamp"}
] %}

{{ return(columns) }}

{% endmacro %}

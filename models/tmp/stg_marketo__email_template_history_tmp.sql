{{ config(enabled=var('customer360__using_marketo', true)) }}

select *
from {{ var('email_template_history') }}

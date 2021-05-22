{{ config(enabled=var('marketo__enable_campaigns') and var('marketo__enable_programs')) }}

select *
from {{ var('program') }}

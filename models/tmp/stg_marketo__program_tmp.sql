{{ config(enabled=var('marketo__enable_campaigns', False) and var('marketo__enable_programs', False) and var('customer360__using_marketo', true)) }}

select *
from {{ var('program') }}

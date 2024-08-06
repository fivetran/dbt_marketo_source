{{ config(enabled=var('marketo__activity_delete_lead_enabled', True) and var('customer360__using_marketo', true)) }}

select *
from {{ var('activity_delete_lead') }}

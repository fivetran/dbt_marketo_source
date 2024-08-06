{{ config(enabled=var('marketo__enable_campaigns', False) and var('customer360__using_marketo', true)) }}

select *
from {{ var('campaign') }}

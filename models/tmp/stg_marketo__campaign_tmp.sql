{{ config(enabled=var('marketo__enable_campaigns')) }}

select *
from {{ var('campaign') }}

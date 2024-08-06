{{ config(enabled=var('customer360__using_marketo', true)) }}

select *
from {{ var('activity_email_bounced') }}

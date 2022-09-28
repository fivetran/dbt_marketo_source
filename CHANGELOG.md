# dbt_marketo_source v0.7.3
PR [28](https://github.com/fivetran/dbt_marketo_source/pull/28) incorporates the following updates:
## Features
- 🎉 Databricks compatibility 🎉
- Ability to disable `activity_delete_lead` model if necessary (see [README](link) for instructions). 
- Updated structure of config default variables for enabling `campaigns` and `program` models to avoid conflicting with a user's settings. 

# dbt_marketo_source v0.7.2
## Bug Fixes
- Updated surrogate key `email_send_id` to include `primary_attribute_value_id`. The previous key was at a campaign level grain, not an email level grain. This is pertinent in the case where there are multiple emails that are part of the same campaign.
[#26](https://github.com/fivetran/dbt_marketo_source/pull/26)
## Contributors
- [sfc-gh-sugupta](https://github.com/sfc-gh-sugupta) [#25](https://github.com/fivetran/dbt_marketo_source/issues/25)
# dbt_marketo_source v0.7.1

## Bug Fixes
- Explicitly cast the activity_timestamp field as `timestamp without time zone`, otherwise in Redshift this would be passed down as `timestamp with time zone` and cause date functions to fail (https://github.com/fivetran/dbt_marketo_source/issues/22)
[#23](https://github.com/fivetran/dbt_marketo_source/pull/23)
# dbt_marketo_source v0.7.0

## Bug Fixes
- Previously, `merged_into_lead_id` and `lead_id` were erroneously switched in `stg_marketo__lead`. This release switches them back, appropriately casting `merged_into_lead_id` as a string (it can have multiple comma-separated values) and `lead_id` as an integer (https://github.com/fivetran/dbt_marketo/issues/17).

This is a **BREAKING CHANGE** as you will need to run a full refresh due to the columns' differing data types. 

# dbt_marketo_source v0.6.0
🎉 dbt v1.0.0 Compatibility 🎉
## 🚨 Breaking Changes 🚨
- Adjusts the `require-dbt-version` to now be within the range [">=1.0.0", "<2.0.0"]. Additionally, the package has been updated for dbt v1.0.0 compatibility. If you are using a dbt version <1.0.0, you will need to upgrade in order to leverage the latest version of the package.
  - For help upgrading your package, I recommend reviewing this GitHub repo's Release Notes on what changes have been implemented since your last upgrade.
  - For help upgrading your dbt project to dbt v1.0.0, I recommend reviewing dbt-labs [upgrading to 1.0.0 docs](https://docs.getdbt.com/docs/guides/migration-guide/upgrading-to-1-0-0) for more details on what changes must be made.
- Upgrades the package dependency to refer to the latest `dbt_fivetran_utils`. The latest `dbt_fivetran_utils` package also has a dependency on `dbt_utils` [">=0.8.0", "<0.9.0"].
  - Please note, if you are installing a version of `dbt_utils` in your `packages.yml` that is not in the range above then you will encounter a package dependency error.

# dbt_marketo_source v0.1.0 -> v0.5.0
Refer to the relevant release notes on the Github repository for specific details for the previous releases. Thank you!
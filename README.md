[![Apache License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) ![dbt Logo and Version](https://img.shields.io/static/v1?logo=dbt&label=dbt-version&message=>=1.0.0,<2.0.0&color=orange)
# Marketo Source ([docs](https://fivetran-dbt-marketo.netlify.app/#!/overview))

This package models Marketo data from [Fivetran's connector](https://fivetran.com/docs/applications/marketo). It uses data in the format described by [this ERD](https://fivetran.com/docs/applications/marketo#schema).

This package enriches your Fivetran data by doing the following:

* Adds descriptions to tables and columns that are synced using Fivetran
* Adds column-level testing where applicable. For example, all primary keys are tested for uniqueness and non-null values.
* Models staging tables, which will be used in our transform package

## Models

This package contains staging models, designed to work simultaneously with our [Marketo modeling package](https://github.com/fivetran/dbt_marketo). The staging models:

* Remove any rows that are soft-deleted
* Name columns consistently across all packages:
  * Boolean fields are prefixed with `is_` or `has_`
  * Timestamps are appended with `_at`
  * ID primary keys are prefixed with the name of the table. For example, the user table's ID column is renamed user_id.

## Installation Instructions
`dbt_marketo_source` currently supports `dbt 0.20.x`.

Check [dbt Hub](https://hub.getdbt.com/) for the latest installation instructions, or [read the dbt docs](https://docs.getdbt.com/docs/package-management) for more information on installing packages.

Include in your `packages.yml`

```yaml
packages:
  - package: fivetran/marketo_source
    version: [">=0.6.0", "<0.7.0"]
```

## Configuration
By default, this package will look for your Marketo data in the `marketo` schema of your [target database](https://docs.getdbt.com/docs/running-a-dbt-project/using-the-command-line-interface/configure-your-profile). If this is not where your Marketo data is, add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
config-version: 2

vars:
  marketo_source:
    marketo_database: your_database_name
    marketo_schema: your_schema_name 
```

### Changing the Build Schema
By default this package will build the Marketo staging models within a schema titled (<target_schema> + `_stg_marketo`) in your target database. If this is not where you would like your Marketo data to be written to, add the following configuration to your `dbt_project.yml` file:

```yml
# dbt_project.yml

...
models:
  marketo_source:
    +schema: my_new_schema_name # leave blank for just the target_schema
```

### Enabling Models
This package takes into consideration tables that may not be synced due to slowness caused by the Marketo API.  By default the `campaign` and `program` models are disabled.  If you sync these tables, enable the modeling done by adding the following to your `dbt_project.yml` file:
```yml
# dbt_project.yml

...
vars:
    marketo__enable_campaigns:  True         #Enable if Fivetran is syncing the campaign table
    marketo__enable_programs:   True         #Enable if Fivetran is syncing the program table
```

## Contributions

Additional contributions to this package are very welcome! Please create issues
or open PRs against `main`. Check out 
[this post](https://discourse.getdbt.com/t/contributing-to-a-dbt-package/657) 
on the best workflow for contributing to a package.

## Database Support
This package has been tested on BigQuery, Snowflake and Redshift.

## Resources:
- Provide [feedback](https://www.surveymonkey.com/r/DQ7K7WW) on our existing dbt packages or what you'd like to see next
- Have questions, feedback, or need help? Book a time during our office hours [using Calendly](https://calendly.com/fivetran-solutions-team/fivetran-solutions-team-office-hours) or email us at solutions@fivetran.com
- Find all of Fivetran's pre-built dbt packages in our [dbt hub](https://hub.getdbt.com/fivetran/)
- Learn how to orchestrate [dbt transformations with Fivetran](https://fivetran.com/docs/transformations/dbt)
- Learn more about Fivetran overall [in our docs](https://fivetran.com/docs)
- Check out [Fivetran's blog](https://fivetran.com/blog)
- Learn more about dbt [in the dbt docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](http://slack.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the dbt blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices

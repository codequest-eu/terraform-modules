# RDS MySQL

Creates an RDS MySQL database instance

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |
| `random` | `>= 2.1.2` |

## Inputs

* `backup_retention_period` (`number`, default: `7`)

    The days to retain backups for. Must be between 0 and 35.

* `create` (`bool`, default: `true`)

    Should resources be created

* `create_management_lambda` (`bool`, default: `true`)

    Should the management lambda function be created

* `db` (`string`, default: `null`)

    The name of the database to create when the DB instance is created, defaults to project name converted to snake_case

* `environment` (`string`, required)

    Kebab-cased environment name, eg. development, staging, production

* `instance_type` (`string`, required)

    The instance type of the RDS instance

* `multi_az` (`bool`, default: `true`)

    Specifies if the RDS instance is multi-AZ

* `mysql_version` (`string`, default: `"5.7.28"`)

    RDS MySQL engine version

* `password` (`string`, required)

    Password for the master DB user

* `port` (`number`, default: `3306`)

    The port on which the DB accepts connections

* `prevent_destroy` (`bool`, default: `true`)

    Should the DB be protected from accidental deletion

* `project` (`string`, required)

    Kebab-cased project name

* `public` (`bool`, default: `false`)

    Should the DB be publicly accessible, will have no effect if placed in a private subnet

* `security_group_ids` (`list(string)`, default: `[]`)

    Security group ids which should have access to the DB

* `storage` (`number`, required)

    The allocated storage in gibibytes

* `subnet_ids` (`list(string)`, required)

    VPC subnet IDs in which the DB should be created

* `tags` (`map(string)`, default: `{}`)

    Tags to add to resources that support them

* `username` (`string`, required)

    Username for the master DB user

* `vpc_id` (`string`, required)

    VPC ID in which the DB should be created



## Outputs

* `db`

    DB name

* `host`

    DB host

* `management_lambda`

    Management lambda function outputs

* `password`

    DB master password

* `port`

    DB port

* `security_group_id`

    DB security group id

* `url`

    DB connection url

* `username`

    DB master username

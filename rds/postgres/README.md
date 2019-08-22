# RDS Postgres

Creates an RDS PostgreSQL database instance

<!-- bin/docs -->

## Versions

| | |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.22.0` |
| `random` | `>= 2.1.2` |

## Inputs

* `backup_retention_period` (`number`, default: `7`)

    The days to retain backups for. Must be between 0 and 35.

* `create` (`bool`, default: `true`)

    Should resources be created

* `db` (`string`, required)

    The name of the database to create when the DB instance is created, defaults to project name converted to snake_case

* `environment` (`string`, required)

    Kebab-cased environment name, eg. development, staging, production

* `instance_type` (`string`, required)

    The instance type of the RDS instance

* `multi_az` (`bool`, default: `true`)

    Specifies if the RDS instance is multi-AZ

* `password` (`string`, required)

    Password for the master DB user, if not provided a random one will be generated

* `password_length` (`number`, default: `32`)

    Random password length

* `port` (`number`, default: `5432`)

    The port on which the DB accepts connections

* `postgres_version` (`string`, default: `"10.6"`)

    RDS Postgres engine version

* `prevent_destroy` (`bool`, default: `true`)

    Should the DB be protected from accidental deletion

* `project` (`string`, required)

    Kebab-cased project name

* `public` (`bool`, required)

    Should the DB be publicly accessible, will have no effect if placed in a private subnet

* `security_group_ids` (`list(string)`, required)

    Security group ids which should have access to the DB

* `storage` (`number`, required)

    The allocated storage in gibibytes

* `subnet_ids` (`list(string)`, required)

    VPC subnet IDs in which the DB should be created

* `tags` (`map(string)`, required)

    Tags to add to resources that support them

* `username` (`string`, required)

    Username for the master DB user, if not provided a random one will be generated

* `username_length` (`number`, default: `8`)

    Random username length

* `vpc_id` (`string`, required)

    VPC ID in which the DB should be created



## Outputs

* `db`

    DB name

* `host`

    DB host

* `password`

    DB master password

* `port`

    DB port

* `url`

    DB connection url

* `username`

    DB master username

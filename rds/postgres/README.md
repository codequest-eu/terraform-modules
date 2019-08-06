# RDS Postgres

Creates an RDS PostgreSQL database instance

## Inputs

| Name                      | Description                                                                                                          |  Type  |  Default  | Required |
| ------------------------- | -------------------------------------------------------------------------------------------------------------------- | :----: | :-------: | :------: |
| backup\_retention\_period | The days to retain backups for. Must be between 0 and 35.                                                            | string |   `"7"`   |    no    |
| db                        | The name of the database to create when the DB instance is created, defaults to project name converted to snake_case | string |   `""`    |    no    |
| environment               | Kebab-cased environment name, eg. development, staging, production                                                   | string |    n/a    |   yes    |
| instance\_type            | The instance type of the RDS instance                                                                                | string |    n/a    |   yes    |
| multi\_az                 | Specifies if the RDS instance is multi-AZ                                                                            | string | `"true"`  |    no    |
| password                  | Password for the master DB user, if not provided a random one will be generated                                      | string |   `""`    |    no    |
| password\_length          | Random password length                                                                                               | string |  `"32"`   |    no    |
| port                      | The port on which the DB accepts connections                                                                         | string | `"5432"`  |    no    |
| postgres\_version         | RDS Postgres engine version                                                                                          | string | `"10.6"`  |    no    |
| prevent\_destroy          | Should the DB be protected from accidental deletion                                                                  | string | `"true"`  |    no    |
| project                   | Kebab-cased project name                                                                                             | string |    n/a    |   yes    |
| public                    | Should the DB be publicly accessible, will have no effect if placed in a private subnet                              | string | `"false"` |    no    |
| security\_group\_ids      | Security group ids which should have access to the DB                                                                |  list  | `<list>`  |    no    |
| storage                   | The allocated storage in gibibytes                                                                                   | string |    n/a    |   yes    |
| subnet\_ids               | VPC subnet IDs in which the DB should be created                                                                     |  list  |    n/a    |   yes    |
| tags                      | Tags to add to resources that support them                                                                           |  map   |  `<map>`  |    no    |
| username                  | Username for the master DB user, if not provided a random one will be generated                                      | string |   `""`    |    no    |
| username\_length          | Random username length                                                                                               | string |   `"8"`   |    no    |
| vpc\_id                   | VPC ID in which the DB should be created                                                                             | string |    n/a    |   yes    |

## Outputs

| Name     | Description        |
| -------- | ------------------ |
| db       | DB name            |
| host     | DB host            |
| password | DB master password |
| port     | DB port            |
| url      | DB connection url  |
| username | DB master username |


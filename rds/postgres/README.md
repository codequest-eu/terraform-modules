# RDS Postgres

Creates an RDS PostgreSQL database instance

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <0.16 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.40.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.1.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.40.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_management_lambda"></a> [management\_lambda](#module\_management\_lambda) | ./management_lambda | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_db_instance.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_db_subnet_group.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_security_group.db](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.management_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | The days to retain backups for. Must be between 0 and 35. | `number` | `7` | no |
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_create_management_lambda"></a> [create\_management\_lambda](#input\_create\_management\_lambda) | Should the management lambda function be created | `bool` | `true` | no |
| <a name="input_db"></a> [db](#input\_db) | The name of the database to create when the DB instance is created, defaults to project name converted to snake\_case | `string` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Kebab-cased environment name, eg. development, staging, production | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | The instance type of the RDS instance | `string` | n/a | yes |
| <a name="input_multi_az"></a> [multi\_az](#input\_multi\_az) | Specifies if the RDS instance is multi-AZ | `bool` | `true` | no |
| <a name="input_password"></a> [password](#input\_password) | Password for the master DB user | `string` | n/a | yes |
| <a name="input_port"></a> [port](#input\_port) | The port on which the DB accepts connections | `number` | `5432` | no |
| <a name="input_postgres_version"></a> [postgres\_version](#input\_postgres\_version) | RDS Postgres engine version | `string` | `"10.15"` | no |
| <a name="input_prevent_destroy"></a> [prevent\_destroy](#input\_prevent\_destroy) | Should the DB be protected from accidental deletion | `bool` | `true` | no |
| <a name="input_project"></a> [project](#input\_project) | Kebab-cased project name | `string` | n/a | yes |
| <a name="input_public"></a> [public](#input\_public) | Should the DB be publicly accessible, will have no effect if placed in a private subnet | `bool` | `false` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Security group ids which should have access to the DB | `list(string)` | `[]` | no |
| <a name="input_storage"></a> [storage](#input\_storage) | The allocated storage in gibibytes | `number` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | VPC subnet IDs in which the DB should be created | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources that support them | `map(string)` | `{}` | no |
| <a name="input_username"></a> [username](#input\_username) | Username for the master DB user | `string` | n/a | yes |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID in which the DB should be created | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db"></a> [db](#output\_db) | DB name |
| <a name="output_host"></a> [host](#output\_host) | DB host |
| <a name="output_management_lambda"></a> [management\_lambda](#output\_management\_lambda) | Management lambda function outputs |
| <a name="output_password"></a> [password](#output\_password) | DB master password |
| <a name="output_port"></a> [port](#output\_port) | DB port |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | DB security group id |
| <a name="output_url"></a> [url](#output\_url) | DB connection url |
| <a name="output_username"></a> [username](#output\_username) | DB master username |
<!-- END_TF_DOCS -->

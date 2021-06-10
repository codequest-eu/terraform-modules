# ecs/task/log_group

Creates a CloudWatch log group for a container and outputs container logging configuration.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.40.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_container"></a> [container](#input\_container) | Container name within the task definition | `string` | `""` | no |
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Kebab-cased environment name, eg. development, staging, production. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Kebab-cased project name | `string` | n/a | yes |
| <a name="input_retention"></a> [retention](#input\_retention) | Log retention in days.<br><br>    Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0.<br>    If you select 0, the events in the log group are always retained and never expire. | `number` | `7` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources that support them | `map(string)` | `{}` | no |
| <a name="input_task"></a> [task](#input\_task) | ECS task definition name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | CloudWatch log group ARN |
| <a name="output_container_config"></a> [container\_config](#output\_container\_config) | Container definition logging configuration |
| <a name="output_container_config_json"></a> [container\_config\_json](#output\_container\_config\_json) | Container definition logging configuration JSON |
| <a name="output_name"></a> [name](#output\_name) | CloudWatch log group name |
<!-- END_TF_DOCS -->

# ecs/services/statsd

Adds a statsd server, using cloudwatch agent, to each ECS instance

<!-- prettier-ignore-start -->
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
| [aws_ecs_service.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_ecs_task_definition.task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_iam_role.task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.task_execution_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.task_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_by_ecs_task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aggregation_interval"></a> [aggregation\_interval](#input\_aggregation\_interval) | How often should the metrics be aggregated in seconds | `number` | `60` | no |
| <a name="input_cluster_arn"></a> [cluster\_arn](#input\_cluster\_arn) | ARN of the ECS cluster to add the daemon to | `string` | n/a | yes |
| <a name="input_collection_interval"></a> [collection\_interval](#input\_collection\_interval) | How often should the metrics be collected in seconds | `number` | `10` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether any resources should be created | `bool` | `true` | no |
| <a name="input_debug"></a> [debug](#input\_debug) | Whether to enable cloudwatch agent debug mode | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the service and task definition | `string` | `"statsd"` | no |
| <a name="input_port"></a> [port](#input\_port) | Port to listen on on each ECS instance | `number` | `8125` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_address"></a> [address](#output\_address) | StatsD address |
| <a name="output_host"></a> [host](#output\_host) | StatsD server host - IP of the docker host |
| <a name="output_port"></a> [port](#output\_port) | StatsD server port on the docker host |
| <a name="output_service_id"></a> [service\_id](#output\_service\_id) | ECS service id |
| <a name="output_service_name"></a> [service\_name](#output\_service\_name) | ECS service name |
| <a name="output_task_arn"></a> [task\_arn](#output\_task\_arn) | Task definition ARN |
| <a name="output_task_family"></a> [task\_family](#output\_task\_family) | Task definition family |
<!-- END_TF_DOCS -->
<!-- prettier-ignore-end -->

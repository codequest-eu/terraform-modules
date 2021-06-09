# ecs/services/worker

Creates an ECS service for background workers

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.40.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudwatch_consts"></a> [cloudwatch\_consts](#module\_cloudwatch\_consts) | ./../../../cloudwatch/consts | n/a |
| <a name="module_metric_average_cpu_reservation"></a> [metric\_average\_cpu\_reservation](#module\_metric\_average\_cpu\_reservation) | ./../../../cloudwatch/metric | n/a |
| <a name="module_metric_average_memory_reservation"></a> [metric\_average\_memory\_reservation](#module\_metric\_average\_memory\_reservation) | ./../../../cloudwatch/metric | n/a |
| <a name="module_metrics_cpu_utilization"></a> [metrics\_cpu\_utilization](#module\_metrics\_cpu\_utilization) | ./../../../cloudwatch/metric/many | n/a |
| <a name="module_metrics_memory_utilization"></a> [metrics\_memory\_utilization](#module\_metrics\_memory\_utilization) | ./../../../cloudwatch/metric/many | n/a |
| <a name="module_metrics_tasks"></a> [metrics\_tasks](#module\_metrics\_tasks) | ./../../../cloudwatch/metric/many | n/a |
| <a name="module_widget_cpu_utilization"></a> [widget\_cpu\_utilization](#module\_widget\_cpu\_utilization) | ./../../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_memory_utilization"></a> [widget\_memory\_utilization](#module\_widget\_memory\_utilization) | ./../../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_scaling"></a> [widget\_scaling](#module\_widget\_scaling) | ./../../../cloudwatch/metric_widget | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ecs_service.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_arn.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/arn) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_arn"></a> [cluster\_arn](#input\_cluster\_arn) | ARN of the ECS cluster to create the service in | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_deployment_max_percent"></a> [deployment\_max\_percent](#input\_deployment\_max\_percent) | The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. Rounded down to get the maximum number of running tasks. | `number` | `200` | no |
| <a name="input_deployment_min_percent"></a> [deployment\_min\_percent](#input\_deployment\_min\_percent) | The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment. Rounded up to get the minimum number of running tasks. | `number` | `50` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | The number of instances of the task definition to place and keep running. | `number` | `2` | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | The launch type on which to run your service. Either EC2 or FARGATE. | `string` | `"EC2"` | no |
| <a name="input_name"></a> [name](#input\_name) | ECS service name | `string` | n/a | yes |
| <a name="input_task_definition_arn"></a> [task\_definition\_arn](#input\_task\_definition\_arn) | ECS task definition ARN to run as a service | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Service id |
| <a name="output_metrics"></a> [metrics](#output\_metrics) | Cloudwatch metrics, see [metrics.tf](./metrics.tf) |
| <a name="output_widgets"></a> [widgets](#output\_widgets) | Cloudwatch dashboard widgets, see [widgets.tf](./widgets.tf) |
<!-- END_TF_DOCS -->

# ecs/services/web

Creates an ECS service exposed to the internet using an Application Load Balancer.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.42.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.42.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudwatch_consts"></a> [cloudwatch\_consts](#module\_cloudwatch\_consts) | ./../../../cloudwatch/consts | n/a |
| <a name="module_metric_average_cpu_reservation"></a> [metric\_average\_cpu\_reservation](#module\_metric\_average\_cpu\_reservation) | ./../../../cloudwatch/metric | n/a |
| <a name="module_metric_average_memory_reservation"></a> [metric\_average\_memory\_reservation](#module\_metric\_average\_memory\_reservation) | ./../../../cloudwatch/metric | n/a |
| <a name="module_metric_connection_error_percentage"></a> [metric\_connection\_error\_percentage](#module\_metric\_connection\_error\_percentage) | ./../../../cloudwatch/metric_expression | n/a |
| <a name="module_metric_connection_errors"></a> [metric\_connection\_errors](#module\_metric\_connection\_errors) | ./../../../cloudwatch/metric | n/a |
| <a name="module_metric_healthy_tasks"></a> [metric\_healthy\_tasks](#module\_metric\_healthy\_tasks) | ./../../../cloudwatch/metric | n/a |
| <a name="module_metric_requests"></a> [metric\_requests](#module\_metric\_requests) | ./../../../cloudwatch/metric | n/a |
| <a name="module_metrics_cpu_utilization"></a> [metrics\_cpu\_utilization](#module\_metrics\_cpu\_utilization) | ./../../../cloudwatch/metric/many | n/a |
| <a name="module_metrics_memory_utilization"></a> [metrics\_memory\_utilization](#module\_metrics\_memory\_utilization) | ./../../../cloudwatch/metric/many | n/a |
| <a name="module_metrics_response_status_percentages"></a> [metrics\_response\_status\_percentages](#module\_metrics\_response\_status\_percentages) | ./../../../cloudwatch/metric_expression/many | n/a |
| <a name="module_metrics_response_statuses"></a> [metrics\_response\_statuses](#module\_metrics\_response\_statuses) | ./../../../cloudwatch/metric/many | n/a |
| <a name="module_metrics_response_time"></a> [metrics\_response\_time](#module\_metrics\_response\_time) | ./../../../cloudwatch/metric/many | n/a |
| <a name="module_metrics_tasks"></a> [metrics\_tasks](#module\_metrics\_tasks) | ./../../../cloudwatch/metric/many | n/a |
| <a name="module_widget_cpu_utilization"></a> [widget\_cpu\_utilization](#module\_widget\_cpu\_utilization) | ./../../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_memory_utilization"></a> [widget\_memory\_utilization](#module\_widget\_memory\_utilization) | ./../../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_response_percentages"></a> [widget\_response\_percentages](#module\_widget\_response\_percentages) | ./../../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_response_time"></a> [widget\_response\_time](#module\_widget\_response\_time) | ./../../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_responses"></a> [widget\_responses](#module\_widget\_responses) | ./../../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_scaling"></a> [widget\_scaling](#module\_widget\_scaling) | ./../../../cloudwatch/metric_widget | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ecs_service.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_service) | resource |
| [aws_lb_listener_rule.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_target_group.service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_arn.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/arn) | data source |
| [aws_lb.lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb) | data source |
| [aws_lb_listener.listener](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb_listener) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_arn"></a> [cluster\_arn](#input\_cluster\_arn) | ARN of the ECS cluster to create the service in | `string` | n/a | yes |
| <a name="input_container"></a> [container](#input\_container) | Container to forward requests to, defaults to service name | `string` | `null` | no |
| <a name="input_container_port"></a> [container\_port](#input\_container\_port) | Port on which the container is listening | `number` | `80` | no |
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_deployment_max_percent"></a> [deployment\_max\_percent](#input\_deployment\_max\_percent) | The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. Rounded down to get the maximum number of running tasks. | `number` | `200` | no |
| <a name="input_deployment_min_percent"></a> [deployment\_min\_percent](#input\_deployment\_min\_percent) | The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment. Rounded up to get the minimum number of running tasks. | `number` | `50` | no |
| <a name="input_deregistration_delay"></a> [deregistration\_delay](#input\_deregistration\_delay) | Connection draining time in seconds. | `number` | `30` | no |
| <a name="input_desired_count"></a> [desired\_count](#input\_desired\_count) | The number of instances of the task definition to place and keep running. | `number` | `2` | no |
| <a name="input_healthcheck_interval"></a> [healthcheck\_interval](#input\_healthcheck\_interval) | How often, in seconds, healtchecks should be sent. | `number` | `5` | no |
| <a name="input_healthcheck_path"></a> [healthcheck\_path](#input\_healthcheck\_path) | Healthcheck endpoint path | `string` | `"/healthcheck"` | no |
| <a name="input_healthcheck_status"></a> [healthcheck\_status](#input\_healthcheck\_status) | Healthy response status | `number` | `200` | no |
| <a name="input_healthcheck_timeout"></a> [healthcheck\_timeout](#input\_healthcheck\_timeout) | Healthcheck request timeout, in seconds. | `number` | `2` | no |
| <a name="input_healthy_threshold"></a> [healthy\_threshold](#input\_healthy\_threshold) | The number of consecutive health checks successes required before considering an unhealthy target healthy | `number` | `2` | no |
| <a name="input_launch_type"></a> [launch\_type](#input\_launch\_type) | The launch type on which to run your service. Either EC2 or FARGATE. | `string` | `"EC2"` | no |
| <a name="input_listener_arn"></a> [listener\_arn](#input\_listener\_arn) | ALB listener ARN | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | ECS service name | `string` | n/a | yes |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | ARN of the IAM role that allows Amazon ECS to make calls to your load balancer on your behalf. | `string` | n/a | yes |
| <a name="input_rule_domain"></a> [rule\_domain](#input\_rule\_domain) | Domain to route to the service | `string` | `"*"` | no |
| <a name="input_rule_path"></a> [rule\_path](#input\_rule\_path) | Path pattern to route to the service | `string` | `"/*"` | no |
| <a name="input_rule_priority"></a> [rule\_priority](#input\_rule\_priority) | Priority to set on the ALB rule | `number` | `null` | no |
| <a name="input_slow_start"></a> [slow\_start](#input\_slow\_start) | The amount time to warm up before the load balancer sends the full share of requests. | `number` | `0` | no |
| <a name="input_target_group_name"></a> [target\_group\_name](#input\_target\_group\_name) | Load balancer target group name, defaults to {cluster name}-{service name}. Max 32 characters. | `string` | `null` | no |
| <a name="input_task_definition_arn"></a> [task\_definition\_arn](#input\_task\_definition\_arn) | ECS task definition ARN to run as a service | `string` | n/a | yes |
| <a name="input_unhealthy_threshold"></a> [unhealthy\_threshold](#input\_unhealthy\_threshold) | The number of consecutive health check failures required before considering the target unhealthy | `number` | `2` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Service id |
| <a name="output_metrics"></a> [metrics](#output\_metrics) | Cloudwatch metrics, see [metrics.tf](./metrics.tf) |
| <a name="output_target_group_arn"></a> [target\_group\_arn](#output\_target\_group\_arn) | Load balancer target group ARN |
| <a name="output_target_group_name"></a> [target\_group\_name](#output\_target\_group\_name) | Load balancer target group name |
| <a name="output_widgets"></a> [widgets](#output\_widgets) | Cloudwatch dashboard widgets, see [widgets.tf](./widgets.tf) |
<!-- END_TF_DOCS -->

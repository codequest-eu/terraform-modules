# ecs/services/statsd

Adds a statsd server, using cloudwatch agent, to each ECS instance

## Deployment failures

To mark the ECS service update as a failure if something goes wrong the defaults are:

- `wait_for_steady_state = true` to wait for the service to be deployed
- `deployment_timeout = "10m"` wait 10 minutes, if it takes longer terraform will mark the update as a failure
- `deployment_rollback = true` enables roll back using the [ECS deployment circuit breaker](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/deployment-circuit-breaker.html)

`deployment_rollback` and `deployment_timeout` are independent of each other,
because we have no control over ECS deployment circuit breaker thresholds.
There's also no way at the moment to wait for deployment failure.

This means that you have to make sure `deployment_timeout` is lower than
the time it takes for ECS to mark the deployment as failed. Otherwise the
rollback might cause the service to enter steady state, which will then
be picked up by terraform and it will mark terraform apply as a success,
even though the deployment failed.

https://github.com/hashicorp/terraform-provider-aws/issues/20858

<!-- prettier-ignore-start -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <2.0 |
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
| <a name="input_deployment_rollback"></a> [deployment\_rollback](#input\_deployment\_rollback) | Whether ECS should roll back to the previous version when it detects a failure using deployment circuit breaker | `bool` | `true` | no |
| <a name="input_deployment_timeout"></a> [deployment\_timeout](#input\_deployment\_timeout) | Timeout for updating the ECS service | `string` | `"10m"` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the service and task definition | `string` | `"statsd"` | no |
| <a name="input_port"></a> [port](#input\_port) | Port to listen on on each ECS instance | `number` | `8125` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources | `map(string)` | `{}` | no |
| <a name="input_wait_for_steady_state"></a> [wait\_for\_steady\_state](#input\_wait\_for\_steady\_state) | Wait for the service to reach a steady state | `bool` | `true` | no |

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

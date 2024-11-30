# ecs/task/container_definition

Creates a container definition that can be provided to a task definition

<!-- prettier-ignore-start -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <2.0 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_command"></a> [command](#input\_command) | Command override. | `list(string)` | `null` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | The number of cpu units (1/1024 vCPU) the Amazon ECS container agent will reserve for the container. | `number` | `0` | no |
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_enable_environment_parameters_hash"></a> [enable\_environment\_parameters\_hash](#input\_enable\_environment\_parameters\_hash) | Inject an `SSM_PARAMETERS_HASH` environment variable to ensure that whenever parameter versions change the container definition will also change.<br>This makes sure that any services will be updated with new task definitions whenever a parameter is updated, so the service itself doesn't need to poll SSM. | `bool` | `true` | no |
| <a name="input_entry_point"></a> [entry\_point](#input\_entry\_point) | Entry point override. | `list(string)` | `null` | no |
| <a name="input_environment_parameters"></a> [environment\_parameters](#input\_environment\_parameters) | Environment variables that should be set to Systems Manager parameter values.<br>Maps environment variable names to parameters. | <pre>map(object({<br>    arn     = string<br>    version = number<br>  }))</pre> | `{}` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | Environment variables to pass to a container. | `map(string)` | `{}` | no |
| <a name="input_essential"></a> [essential](#input\_essential) | If the essential parameter of a container is marked as true, and that container fails or stops for any reason, all other containers that are part of the task are stopped. | `bool` | `true` | no |
| <a name="input_healthcheck_command"></a> [healthcheck\_command](#input\_healthcheck\_command) | Command that the container runs to determine if it is healthy | `string` | `null` | no |
| <a name="input_healthcheck_interval"></a> [healthcheck\_interval](#input\_healthcheck\_interval) | The time period in seconds between each health check execution. You may specify between 5 and 300 seconds. | `number` | `30` | no |
| <a name="input_healthcheck_retries"></a> [healthcheck\_retries](#input\_healthcheck\_retries) | The number of times to retry a failed health check before the container is considered unhealthy. You may specify between 1 and 10 retries. | `number` | `2` | no |
| <a name="input_healthcheck_shell"></a> [healthcheck\_shell](#input\_healthcheck\_shell) | Whether the healthcheck\_command should be run using a shell | `bool` | `true` | no |
| <a name="input_healthcheck_start_period"></a> [healthcheck\_start\_period](#input\_healthcheck\_start\_period) | The optional grace period to provide containers time to bootstrap before failed health checks count towards the maximum number of retries. You can specify between 0 and 300 seconds. | `number` | `0` | no |
| <a name="input_healthcheck_timeout"></a> [healthcheck\_timeout](#input\_healthcheck\_timeout) | The time period in seconds to wait for a health check to succeed before it is considered a failure. You may specify between 2 and 60 seconds. | `number` | `5` | no |
| <a name="input_image"></a> [image](#input\_image) | Container image | `string` | n/a | yes |
| <a name="input_log_config"></a> [log\_config](#input\_log\_config) | jsonencodable logging configuration | `any` | `null` | no |
| <a name="input_memory_hard_limit"></a> [memory\_hard\_limit](#input\_memory\_hard\_limit) | The amount (in MiB) of memory to present to the container. If your container attempts to exceed the memory specified here, the container is killed. | `number` | `1024` | no |
| <a name="input_memory_soft_limit"></a> [memory\_soft\_limit](#input\_memory\_soft\_limit) | The soft limit (in MiB) of memory to reserve for the container. When system memory is under contention, Docker attempts to keep the container memory to this soft limit; however, your container can consume more memory when needed. | `number` | `256` | no |
| <a name="input_name"></a> [name](#input\_name) | Container name | `string` | n/a | yes |
| <a name="input_ports"></a> [ports](#input\_ports) | List of TCP ports that should be exposed on the host, a random host port will be assigned for each container port | `list(number)` | `[]` | no |
| <a name="input_working_directory"></a> [working\_directory](#input\_working\_directory) | Working directory override. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_definition"></a> [definition](#output\_definition) | container definition |
| <a name="output_json"></a> [json](#output\_json) | container definition JSON |
<!-- END_TF_DOCS -->
<!-- prettier-ignore-end -->

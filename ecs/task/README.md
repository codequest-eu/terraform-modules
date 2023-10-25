# ecs/task

Creates a task definition with a single container and CloudWatch log group

## Image and external CI/CD pipelines

There's 3 ways to specify the container image:

1. By specifying the full image name

   ```terraform
   image = "name:tag"
   ```

2. By specifying name and tag separately

   ```terraform
   image_name = "name"
   image_tag = "tag"
   ```

3. By specifying just the name, so the module fetches the tag used in the latest revision of the task definition

   ```terraform
   image_name = "name"
   ```

   This enables you to update the image externally, eg. with the CI/CD pipeline responsible for the given service.

We recommend creating the task definition using `image` or `image_name` + `image_tag` and then switching to just `image_name` to allow for external updates.

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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_container"></a> [container](#module\_container) | ./container_definition | n/a |
| <a name="module_container_log"></a> [container\_log](#module\_container\_log) | ./log_group | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ecs_task_definition.task](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_task_definition) | resource |
| [aws_ecs_container_definition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ecs_container_definition) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_command"></a> [command](#input\_command) | Command override. | `list(string)` | `null` | no |
| <a name="input_container"></a> [container](#input\_container) | Container name within the task definition, defaults to task name | `string` | `null` | no |
| <a name="input_cpu"></a> [cpu](#input\_cpu) | The number of cpu units (1/1024 vCPU) the Amazon ECS container agent will reserve for the container. | `number` | `0` | no |
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_enable_environment_parameters_hash"></a> [enable\_environment\_parameters\_hash](#input\_enable\_environment\_parameters\_hash) | Inject an `SSM_PARAMETERS_HASH` environment variable to ensure that whenever parameter versions change the container definition will also change.<br>This makes sure that any services will be updated with new task definitions whenever a parameter is updated, so the service itself doesn't need to poll SSM. | `bool` | `true` | no |
| <a name="input_entry_point"></a> [entry\_point](#input\_entry\_point) | Entry point override. | `list(string)` | `null` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Kebab-cased environment name, eg. development, staging, production. | `string` | n/a | yes |
| <a name="input_environment_parameters"></a> [environment\_parameters](#input\_environment\_parameters) | Environment variables that should be set to Systems Manager parameter values.<br>Maps environment variable names to parameters. | <pre>map(object({<br>    arn     = string<br>    version = number<br>  }))</pre> | `{}` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | Environment variables to pass to a container. | `map(string)` | `{}` | no |
| <a name="input_essential"></a> [essential](#input\_essential) | If the essential parameter of a container is marked as true, and that container fails or stops for any reason, all other containers that are part of the task are stopped. | `bool` | `true` | no |
| <a name="input_execution_role_arn"></a> [execution\_role\_arn](#input\_execution\_role\_arn) | The ARN of IAM role that allows ECS to execute your task.<br><br>Required when:<br>- using `environment_parameters` to give ECS access to the SSM parameters<br>- using `launch_type = "FARGATE"` when running the task | `string` | `null` | no |
| <a name="input_image"></a> [image](#input\_image) | Full container image name, including the version tag. Either image or image\_name has to be provided. | `string` | `null` | no |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | Container image name, without the version tag. Either image or image\_name has to be provided. | `string` | `null` | no |
| <a name="input_image_tag"></a> [image\_tag](#input\_image\_tag) | Container image version tag, if omitted will use one from the latest revision. Used only when image\_name is provided. | `string` | `null` | no |
| <a name="input_log_retention"></a> [log\_retention](#input\_log\_retention) | Log retention in days.<br><br>    Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0.<br>    If you select 0, the events in the log group are always retained and never expire. | `number` | `7` | no |
| <a name="input_memory_hard_limit"></a> [memory\_hard\_limit](#input\_memory\_hard\_limit) | The amount (in MiB) of memory to present to the container. If your container attempts to exceed the memory specified here, the container is killed. | `number` | `1024` | no |
| <a name="input_memory_soft_limit"></a> [memory\_soft\_limit](#input\_memory\_soft\_limit) | The soft limit (in MiB) of memory to reserve for the container. When system memory is under contention, Docker attempts to keep the container memory to this soft limit; however, your container can consume more memory when needed. | `number` | `256` | no |
| <a name="input_network_mode"></a> [network\_mode](#input\_network\_mode) | Docker networking mode to use for the containers in the task.<br>Valid values are `none`, `bridge`, `awsvpc`, and `host`. | `string` | `null` | no |
| <a name="input_placement_constraint_expressions"></a> [placement\_constraint\_expressions](#input\_placement\_constraint\_expressions) | Placement constraint expressions for the task in Cluster Query Language | `list(string)` | `[]` | no |
| <a name="input_ports"></a> [ports](#input\_ports) | List of TCP ports that should be exposed on the host, a random host port will be assigned for each container port | `list(number)` | `[]` | no |
| <a name="input_project"></a> [project](#input\_project) | Kebab-cased project name | `string` | n/a | yes |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services. | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources that support them | `map(string)` | `{}` | no |
| <a name="input_task"></a> [task](#input\_task) | ECS task definition name | `string` | n/a | yes |
| <a name="input_task_cpu"></a> [task\_cpu](#input\_task\_cpu) | CPU reserved for the task. Required when running on Fargate. | `number` | `null` | no |
| <a name="input_task_memory"></a> [task\_memory](#input\_task\_memory) | Memory reserved for the task. Required when running on Fargate. | `number` | `null` | no |
| <a name="input_working_directory"></a> [working\_directory](#input\_working\_directory) | Working directory override. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Created task definition revision ARN |
| <a name="output_family"></a> [family](#output\_family) | Task definition family |
| <a name="output_image"></a> [image](#output\_image) | Container image used |
| <a name="output_image_tag"></a> [image\_tag](#output\_image\_tag) | Container image tag used |
| <a name="output_log_group_arn"></a> [log\_group\_arn](#output\_log\_group\_arn) | CloudWatch log group ARN |
| <a name="output_log_group_name"></a> [log\_group\_name](#output\_log\_group\_name) | CloudWatch log group name |
| <a name="output_revision"></a> [revision](#output\_revision) | Task definition revision |
<!-- END_TF_DOCS -->
<!-- prettier-ignore-end -->

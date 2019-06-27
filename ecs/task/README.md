# ecs/task

Creates a task definition with a single container and CloudWatch log group

## Inputs

| Name                   | Description                                                                                                                                                                                                                           |  Type  | Default  | Required |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----: | :------: | :------: |
| command                | Command override, has to be a JSON-encoded array.                                                                                                                                                                                     | string | `"null"` |    no    |
| container              | Container name within the task definition, defaults to task name                                                                                                                                                                      | string |   `""`   |    no    |
| cpu                    | The number of cpu units (1/1024 vCPU) the Amazon ECS container agent will reserve for the container.                                                                                                                                  | string |  `"0"`   |    no    |
| entry\_point           | Entry point override, has to be a JSON-encoded array.                                                                                                                                                                                 | string | `"null"` |    no    |
| environment            | Kebab-cased environment name, eg. development, staging, production.                                                                                                                                                                   | string |   n/a    |   yes    |
| environment\_variables | The environment variables to pass to a container.                                                                                                                                                                                     |  map   | `<map>`  |    no    |
| essential              | If the essential parameter of a container is marked as true, and that container fails or stops for any reason, all other containers that are part of the task are stopped.                                                            | string | `"true"` |    no    |
| image                  | Container image                                                                                                                                                                                                                       | string |   n/a    |   yes    |
| memory\_hard\_limit    | The amount (in MiB) of memory to present to the container. If your container attempts to exceed the memory specified here, the container is killed.                                                                                   | string | `"1024"` |    no    |
| memory\_soft\_limit    | The soft limit (in MiB) of memory to reserve for the container. When system memory is under contention, Docker attempts to keep the container memory to this soft limit; however, your container can consume more memory when needed. | string | `"256"`  |    no    |
| ports                  | List of TCP ports that should be exposed on the host, a random host port will be assigned for each container port                                                                                                                     |  list  | `<list>` |    no    |
| project                | Kebab-cased project name                                                                                                                                                                                                              | string |   n/a    |   yes    |
| role\_arn              | The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services.                                                                                                                                   | string |   `""`   |    no    |
| tags                   | Tags to add to resources that support them                                                                                                                                                                                            |  map   | `<map>`  |    no    |
| task                   | ECS task definition name                                                                                                                                                                                                              | string |   n/a    |   yes    |
| working\_directory     | Working directory override.                                                                                                                                                                                                           | string |   `""`   |    no    |

## Outputs

| Name             | Description               |
| ---------------- | ------------------------- |
| arn              | Task definition ARN       |
| family           | Task definition family    |
| log\_group\_arn  | CloudWatch log group ARN  |
| log\_group\_name | CloudWatch log group name |


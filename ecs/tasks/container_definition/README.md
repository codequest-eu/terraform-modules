# ecs/tasks/container_definition

Creates a container definition that can be provided to a task definition

## Inputs

| Name                | Description                                                                                                                                                                                                                           |  Type  | Default  | Required |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----: | :------: | :------: |
| command             | Command override, has to be a JSON-encoded array.                                                                                                                                                                                     | string | `"null"` |    no    |
| cpu                 | The number of cpu units (1/1024 vCPU) the Amazon ECS container agent will reserve for the container.                                                                                                                                  | string |  `"0"`   |    no    |
| entry\_point        | Entry point override, has to be a JSON-encoded array.                                                                                                                                                                                 | string | `"null"` |    no    |
| environment         | The environment variables to pass to a container.                                                                                                                                                                                     |  map   | `<map>`  |    no    |
| essential           | If the essential parameter of a container is marked as true, and that container fails or stops for any reason, all other containers that are part of the task are stopped.                                                            | string | `"true"` |    no    |
| image               | Container image                                                                                                                                                                                                                       | string |   n/a    |   yes    |
| log\_group          | Log group to which the awslogs log driver sends its log streams.                                                                                                                                                                      | string |   n/a    |   yes    |
| log\_prefix         | Log stream prefix, full stream name will be {log_prefix}/{name}/task-id                                                                                                                                                               | string | `"ecs"`  |    no    |
| log\_region         | AWS region to store logs in, defaults to the AWS provider region                                                                                                                                                                      | string |   `""`   |    no    |
| memory\_hard\_limit | The amount (in MiB) of memory to present to the container. If your container attempts to exceed the memory specified here, the container is killed.                                                                                   | string | `"1024"` |    no    |
| memory\_soft\_limit | The soft limit (in MiB) of memory to reserve for the container. When system memory is under contention, Docker attempts to keep the container memory to this soft limit; however, your container can consume more memory when needed. | string | `"256"`  |    no    |
| name                | Container name                                                                                                                                                                                                                        | string |   n/a    |   yes    |
| ports               | List of TCP ports that should be exposed on the host, a random host port will be assigned for each container port                                                                                                                     |  list  | `<list>` |    no    |
| working\_directory  | Working directory override.                                                                                                                                                                                                           | string |   `""`   |    no    |

## Outputs

| Name       | Description               |
| ---------- | ------------------------- |
| definition | container definition JSON |


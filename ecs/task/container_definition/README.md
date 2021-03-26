# ecs/task/container_definition

Creates a container definition that can be provided to a task definition

<!-- BEGIN_TF_DOCS -->

## Versions

| Provider  | Requirements |
| --------- | ------------ |
| terraform | `>= 0.12`    |

## Inputs

- `command` (`list(string)`, default: `null`)

  Command override.

- `cpu` (`number`, default: `0`)

  The number of cpu units (1/1024 vCPU) the Amazon ECS container agent will reserve for the container.

- `create` (`bool`, default: `true`)

  Should resources be created

- `entry_point` (`list(string)`, default: `null`)

  Entry point override.

- `environment_variables` (`map(string)`, default: `{}`)

  The environment variables to pass to a container.

- `essential` (`bool`, default: `true`)

  If the essential parameter of a container is marked as true, and that container fails or stops for any reason, all other containers that are part of the task are stopped.

- `image` (`string`, required)

  Container image

- `log_config` (``, default: `null`)

  jsonencodable logging configuration

- `memory_hard_limit` (`number`, default: `1024`)

  The amount (in MiB) of memory to present to the container. If your container attempts to exceed the memory specified here, the container is killed.

- `memory_soft_limit` (`number`, default: `256`)

  The soft limit (in MiB) of memory to reserve for the container. When system memory is under contention, Docker attempts to keep the container memory to this soft limit; however, your container can consume more memory when needed.

- `name` (`string`, required)

  Container name

- `ports` (`list(number)`, default: `[]`)

  List of TCP ports that should be exposed on the host, a random host port will be assigned for each container port

- `working_directory` (`string`, default: `null`)

  Working directory override.

## Outputs

- `definition`

  container definition

- `json`

  container definition JSON

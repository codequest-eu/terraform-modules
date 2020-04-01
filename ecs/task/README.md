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

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |

## Inputs

* `command` (`list(string)`, default: `null`)

    Command override.

* `container` (`string`, default: `null`)

    Container name within the task definition, defaults to task name

* `cpu` (`number`, default: `0`)

    The number of cpu units (1/1024 vCPU) the Amazon ECS container agent will reserve for the container.

* `create` (`bool`, default: `true`)

    Should resources be created

* `entry_point` (`list(string)`, default: `null`)

    Entry point override.

* `environment` (`string`, required)

    Kebab-cased environment name, eg. development, staging, production.

* `environment_variables` (`map(string)`, default: `{}`)

    The environment variables to pass to a container.

* `essential` (`bool`, default: `true`)

    If the essential parameter of a container is marked as true, and that container fails or stops for any reason, all other containers that are part of the task are stopped.

* `image` (`string`, default: `null`)

    Full container image name, including the version tag. Either image or image_name has to be provided.

* `image_name` (`string`, default: `null`)

    Container image name, without the version tag. Either image or image_name has to be provided.

* `image_tag` (`string`, default: `null`)

    Container image version tag, if omitted will use one from the latest revision. Used only when image_name is provided.

* `memory_hard_limit` (`number`, default: `1024`)

    The amount (in MiB) of memory to present to the container. If your container attempts to exceed the memory specified here, the container is killed.

* `memory_soft_limit` (`number`, default: `256`)

    The soft limit (in MiB) of memory to reserve for the container. When system memory is under contention, Docker attempts to keep the container memory to this soft limit; however, your container can consume more memory when needed.

* `ports` (`list(number)`, default: `[]`)

    List of TCP ports that should be exposed on the host, a random host port will be assigned for each container port

* `project` (`string`, required)

    Kebab-cased project name

* `role_arn` (`string`, default: `""`)

    The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services.

* `tags` (`map(string)`, default: `{}`)

    Tags to add to resources that support them

* `task` (`string`, required)

    ECS task definition name

* `working_directory` (`string`, default: `null`)

    Working directory override.



## Outputs

* `arn`

    Created task definition revision ARN

* `family`

    Task definition family

* `image`

    Container image used

* `image_tag`

    Container image tag used

* `log_group_arn`

    CloudWatch log group ARN

* `log_group_name`

    CloudWatch log group name

* `revision`

    Task definition revision

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
| image                  | Full container image name, including the version tag. Either image or image_name has to be provided.                                                                                                                                  | string |   `""`   |    no    |
| image\_name            | Container image name, without the version tag. Either image or image_name has to be provided.                                                                                                                                         | string |   `""`   |    no    |
| image\_tag             | Container image version tag, if omitted will use one from the latest revision. Used only when image_name is provided.                                                                                                                 | string |   `""`   |    no    |
| memory\_hard\_limit    | The amount (in MiB) of memory to present to the container. If your container attempts to exceed the memory specified here, the container is killed.                                                                                   | string | `"1024"` |    no    |
| memory\_soft\_limit    | The soft limit (in MiB) of memory to reserve for the container. When system memory is under contention, Docker attempts to keep the container memory to this soft limit; however, your container can consume more memory when needed. | string | `"256"`  |    no    |
| ports                  | List of TCP ports that should be exposed on the host, a random host port will be assigned for each container port                                                                                                                     |  list  | `<list>` |    no    |
| project                | Kebab-cased project name                                                                                                                                                                                                              | string |   n/a    |   yes    |
| role\_arn              | The ARN of IAM role that allows your Amazon ECS container task to make calls to other AWS services.                                                                                                                                   | string |   `""`   |    no    |
| tags                   | Tags to add to resources that support them                                                                                                                                                                                            |  map   | `<map>`  |    no    |
| task                   | ECS task definition name                                                                                                                                                                                                              | string |   n/a    |   yes    |
| working\_directory     | Working directory override.                                                                                                                                                                                                           | string |   `""`   |    no    |

## Outputs

| Name             | Description                          |
| ---------------- | ------------------------------------ |
| arn              | Created task definition revision ARN |
| family           | Task definition family               |
| image            | Container image used                 |
| image\_tag       | Container image tag used             |
| latest\_arn      | Latest task definition revision ARN  |
| latest\_revision | Latest task definition revision      |
| log\_group\_arn  | CloudWatch log group ARN             |
| log\_group\_name | CloudWatch log group name            |
| revision         | Task definition revision             |


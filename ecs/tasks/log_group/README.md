# ecs/tasks/log_group

Creates a CloudWatch log group for a container and outputs container logging configuration.

## Inputs

| Name        | Description                                                         |  Type  | Default | Required |
| ----------- | ------------------------------------------------------------------- | :----: | :-----: | :------: |
| container   | Container name within the task definition                           | string |  `""`   |    no    |
| environment | Kebab-cased environment name, eg. development, staging, production. | string |   n/a   |   yes    |
| project     | Kebab-cased project name                                            | string |   n/a   |   yes    |
| tags        | Tags to add to resources that support them                          |  map   | `<map>` |    no    |
| task        | ECS task definition name                                            | string |   n/a   |   yes    |

## Outputs

| Name              | Description                                     |
| ----------------- | ----------------------------------------------- |
| arn               | CloudWatch log group ARN                        |
| container\_config | Container definition logging configuration JSON |
| name              | CloudWatch log group name                       |


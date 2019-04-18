# ECS Access

Creates IAM resources needed to run host instances and services in the ECS cluster.

## Inputs

| Name        | Description                                                         |  Type  | Default | Required |
| ----------- | ------------------------------------------------------------------- | :----: | :-----: | :------: |
| environment | Kebab-cased environment name, eg. development, staging, production. | string |   n/a   |   yes    |
| project     | Kebab-cased project name                                            | string |   n/a   |   yes    |

## Outputs

| Name                | Description                    |
| ------------------- | ------------------------------ |
| host\_profile\_arn  | ECS host instance profile ARN  |
| host\_profile\_id   | ECS host instance profile ID   |
| host\_profile\_name | ECS host instance profile name |
| host\_role\_arn     | ECS host role ARN              |
| host\_role\_name    | ECS host role name             |


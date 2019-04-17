# ECS worker role

Creates an IAM role and instance profile for worker instances.

## Inputs

| Name        | Description                                                         |  Type  | Default | Required |
| ----------- | ------------------------------------------------------------------- | :----: | :-----: | :------: |
| environment | Kebab-cased environment name, eg. development, staging, production. | string |   n/a   |   yes    |
| project     | Kebab-cased project name                                            | string |   n/a   |   yes    |

## Outputs

| Name          | Description                  |
| ------------- | ---------------------------- |
| profile\_arn  | Worker instance profile ARN  |
| profile\_id   | Worker instance profile ID   |
| profile\_name | Worker instance profile name |
| role\_arn     | Worker role ARN              |
| role\_name    | Worker role name             |


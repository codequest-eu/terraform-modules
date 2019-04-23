# ECS Repository

Creates an ECR repository and a policy for CI which allows push/pull access.

## Inputs

| Name    | Description                                |  Type  | Default | Required |
| ------- | ------------------------------------------ | :----: | :-----: | :------: |
| project | Kebab-cased project name                   | string |   n/a   |   yes    |
| tags    | Tags to add to resources that support them |  map   | `<map>` |    no    |

## Outputs

| Name             | Description                                      |
| ---------------- | ------------------------------------------------ |
| arn              | ECR repository ARN                               |
| ci\_policy\_arn  | IAM policy ARN for CI                            |
| ci\_policy\_name | IAM policy name for CI                           |
| name             | ECR repository name                              |
| registry\_id     | ECR registry id where the repository was created |
| url              | ECR repository URL                               |


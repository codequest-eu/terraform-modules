# Single Page App CI/CD

Creates an AWS user for CI/CD pipelines which can update the contents of the given asset buckets.

## Inputs

| Name         | Description                                              |  Type  | Default | Required |
| ------------ | -------------------------------------------------------- | :----: | :-----: | :------: |
| bucket\_arns | AWS ARNs of all project SPA assets buckets               |  list  |   n/a   |   yes    |
| project      | Kebab-cased project name                                 | string |   n/a   |   yes    |
| tags         | Additional tags to apply to resources that support them. |  map   | `<map>` |    no    |

## Outputs

| Name                    | Description                |
| ----------------------- | -------------------------- |
| ci\_access\_key\_id     | AWS access key for CI user |
| ci\_secret\_access\_key | AWS secret key for CI user |
| ci\_user\_arn           | CI AWS user ARN            |
| ci\_user\_name          | CI AWS user                |


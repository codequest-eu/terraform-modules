# ECS Repository

Creates an ECR repository and a policy for CI which allows push/pull access.

<!-- bin/docs -->

## Versions

| | |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.22.0` |

## Inputs

* `create` (`bool`, default: `true`)

    Should resources be created

* `project` (`string`, required)

    Kebab-cased project name

* `tags` (`map(string)`, required)

    Tags to add to resources that support them



## Outputs

* `arn`

    ECR repository ARN

* `ci_policy_arn`

    IAM policy ARN for CI

* `ci_policy_name`

    IAM policy name for CI

* `name`

    ECR repository name

* `registry_id`

    ECR registry id where the repository was created

* `url`

    ECR repository URL

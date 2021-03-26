# spa/middleware_common

`spa` internal module which creates common resources needed for CloudFront Lambda@Edge middleware.

<!-- BEGIN_TF_DOCS -->

## Versions

| Provider  | Requirements |
| --------- | ------------ |
| terraform | `>= 0.12`    |
| `aws`     | `>= 2.40.0`  |

## Inputs

- `create` (`bool`, default: `true`)

  Should resources be created

- `name_prefix` (`string`, required)

  Name prefix for created resources, usually project-environment

## Outputs

- `role_arn`

  ARN of the IAM role that should be assumed by middleware Lambdas

- `role_name`

  Name of the IAM role that should be assumed by middleware Lambdas

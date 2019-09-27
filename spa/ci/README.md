# Single Page App CI/CD

Creates an AWS user for CI/CD pipelines which can update the contents of the given asset buckets.

> **Deprecated**
>
> `terraform-modules/spa` now provides an IAM policy which can be used with `terraform-modules/iam/user_with_policies` to create a CI user

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.22.0` |

## Inputs

* `bucket_arns` (`list(string)`, required)

    AWS ARNs of all project SPA assets buckets

* `create` (`bool`, default: `true`)

    Should resources be created

* `project` (`string`, required)

    Kebab-cased project name

* `tags` (`map(string)`, required)

    Additional tags to apply to resources that support them.



## Outputs

* `ci_access_key_id`

    AWS access key for CI user

* `ci_secret_access_key`

    AWS secret key for CI user

* `ci_user_arn`

    CI AWS user ARN

* `ci_user_name`

    CI AWS user

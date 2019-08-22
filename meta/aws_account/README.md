# AWS Orgniazation Account

Creates a sub-account for a given project's, environment's resources.

<!-- bin/docs -->

## Versions

| | |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.22.0` |
| `template` | `>= 2.1.2` |

## Inputs

* `create` (`bool`, default: `true`)

    Should resources be created

* `email` (``, required)

    E-mail address of the AWS account owner

* `name` (``, required)

    AWS account name, usually the name of the project

* `role` (``, default: `"OrganizationAccountAccessRole"`)

    IAM role that is automatically created in the new account, which grants the organization's master account permission to access the newly created member account.



## Outputs

* `arn`

    AWS project account ARN

* `id`

    AWS project account id

* `provider_config`

    Terraform AWS provider block

* `role_arn`

    IAM role ARN for root account administrators to manage the member account

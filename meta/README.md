# Meta

Resources needed for terraform and it's CI/CD pipeline:

- AWS S3 bucket for persisting state
- AWS DynamoDB tables for state locking
- AWS IAM user for infrastructure repo CI/CD, which can basically do anything in the given AWS Account

## Terraform backend setup

You need to kick off the meta infrastructure without a remote backend, since it's infrastructure is created by this module.
Here's a step by step tutorial how such a kick off looks like:

1. Add a meta module
2. Run `terraform apply` to create the necessary infrastructure
3. Add backend configuration to your code by pasting the output of:

    ```sh
    terraform output -module NAME_OF_META_MODULE meta_backend_config
    ```

3. Run `terraform init` to transfer the local state to S3
4. Remove local `terraform.tfstate`

Actual project infrastructure state is separate from the meta state, to configure the backend for project infrastructure just paste the output of

```sh
terraform output -module NAME_OF_META_MODULE backend_config
```

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |
| `template` | `>= 2.1.2` |

## Inputs

* `account_role_arn` (`string`, default: `null`)

    If meta is being created in an AWS Organizations Account, ARN of the IAM role that lets root account administrators manage member account resources.

* `create` (`bool`, default: `true`)

    Should resources be created

* `meta_state_key` (`string`, default: `"meta.tfstate"`)

    Meta state file name

* `project` (`string`, required)

    Kebab-cased name of the project, will be used in resource names

* `state_bucket` (`string`, default: `null`)

    Kebab-cased state bucket name override

* `state_key` (`string`, default: `"terraform.tfstate"`)

    State file name

* `tags` (`map(string)`, default: `{}`)

    Additional tags to apply to resources which support them



## Outputs

* `backend_config`

    Terraform backend config block

* `backend_config_map`

    Terraform backend config map

* `backend_type`

    Terraform backend type

* `ci_access_key_id`

    AWS access key for infrastructure CI user

* `ci_secret_access_key`

    AWS secret key for infrastructure CI user

* `ci_user_arn`

    Infrastructure CI AWS user ARN

* `ci_user_name`

    Infrastructure CI AWS user

* `meta_backend_config`

    Terraform meta backend config block

* `meta_backend_config_map`

    Terraform meta backend config map

* `provider_aws_alias_config_template`

    Terraform AWS provider block template for defining aliases, accepts alias and region variables

* `provider_aws_config`

    Terraform AWS provider block

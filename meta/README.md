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

4. Run `terraform init` to transfer the local state to S3
5. Remove local `terraform.tfstate`

Actual project infrastructure state is separate from the meta state, to configure the backend for project infrastructure just paste the output of

```sh
terraform output -module NAME_OF_META_MODULE backend_config
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.40.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | >= 2.1.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.40.0 |
| <a name="provider_template"></a> [template](#provider\_template) | >= 2.1.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_dynamodb_table.meta_lock](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_dynamodb_table.state_lock](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_iam_access_key.ci](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.ci](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.ci](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_s3_bucket.state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.ci](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [template_file.backend_config](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.meta_backend_config](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.provider_aws_alias_config_template](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.provider_aws_config](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_role_arn"></a> [account\_role\_arn](#input\_account\_role\_arn) | If meta is being created in an AWS Organizations Account, ARN of the IAM role that lets root account administrators manage member account resources. | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_meta_state_key"></a> [meta\_state\_key](#input\_meta\_state\_key) | Meta state file name | `string` | `"meta.tfstate"` | no |
| <a name="input_project"></a> [project](#input\_project) | Kebab-cased name of the project, will be used in resource names | `string` | n/a | yes |
| <a name="input_state_bucket"></a> [state\_bucket](#input\_state\_bucket) | Kebab-cased state bucket name override | `string` | `null` | no |
| <a name="input_state_key"></a> [state\_key](#input\_state\_key) | State file name | `string` | `"terraform.tfstate"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to resources which support them | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backend_config"></a> [backend\_config](#output\_backend\_config) | Terraform backend config block |
| <a name="output_backend_config_map"></a> [backend\_config\_map](#output\_backend\_config\_map) | Terraform backend config map |
| <a name="output_backend_type"></a> [backend\_type](#output\_backend\_type) | Terraform backend type |
| <a name="output_ci_access_key_id"></a> [ci\_access\_key\_id](#output\_ci\_access\_key\_id) | AWS access key for infrastructure CI user |
| <a name="output_ci_secret_access_key"></a> [ci\_secret\_access\_key](#output\_ci\_secret\_access\_key) | AWS secret key for infrastructure CI user |
| <a name="output_ci_user_arn"></a> [ci\_user\_arn](#output\_ci\_user\_arn) | Infrastructure CI AWS user ARN |
| <a name="output_ci_user_name"></a> [ci\_user\_name](#output\_ci\_user\_name) | Infrastructure CI AWS user |
| <a name="output_meta_backend_config"></a> [meta\_backend\_config](#output\_meta\_backend\_config) | Terraform meta backend config block |
| <a name="output_meta_backend_config_map"></a> [meta\_backend\_config\_map](#output\_meta\_backend\_config\_map) | Terraform meta backend config map |
| <a name="output_provider_aws_alias_config_template"></a> [provider\_aws\_alias\_config\_template](#output\_provider\_aws\_alias\_config\_template) | Terraform AWS provider block template for defining aliases, accepts alias and region variables |
| <a name="output_provider_aws_config"></a> [provider\_aws\_config](#output\_provider\_aws\_config) | Terraform AWS provider block |
<!-- END_TF_DOCS -->

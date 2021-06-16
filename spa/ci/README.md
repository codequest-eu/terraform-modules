# Single Page App CI/CD

Creates an AWS user for CI/CD pipelines which can update the contents of the given asset buckets.

> **Deprecated**
>
> `terraform-modules/spa` now provides an IAM policy which can be used with `terraform-modules/iam/user` to create a CI user

<!-- prettier-ignore-start -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.40.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.ci](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.ci](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_policy.ci](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_policy) | resource |
| [aws_iam_policy_document.ci](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_arns"></a> [bucket\_arns](#input\_bucket\_arns) | AWS ARNs of all project SPA assets buckets | `list(string)` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_project"></a> [project](#input\_project) | Kebab-cased project name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to resources that support them. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ci_access_key_id"></a> [ci\_access\_key\_id](#output\_ci\_access\_key\_id) | AWS access key for CI user |
| <a name="output_ci_secret_access_key"></a> [ci\_secret\_access\_key](#output\_ci\_secret\_access\_key) | AWS secret key for CI user |
| <a name="output_ci_user_arn"></a> [ci\_user\_arn](#output\_ci\_user\_arn) | CI AWS user ARN |
| <a name="output_ci_user_name"></a> [ci\_user\_name](#output\_ci\_user\_name) | CI AWS user |
<!-- END_TF_DOCS -->
<!-- prettier-ignore-end -->

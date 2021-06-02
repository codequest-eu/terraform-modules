# AWS Orgniazation Account

Creates a sub-account for a given project's, environment's resources.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <0.14 |
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
| [aws_organizations_account.project](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [template_file.provider_config](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_email"></a> [email](#input\_email) | E-mail address of the AWS account owner | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | AWS account name, usually the name of the project | `any` | n/a | yes |
| <a name="input_role"></a> [role](#input\_role) | IAM role that is automatically created in the new account, which grants the organization's master account permission to access the newly created member account. | `string` | `"OrganizationAccountAccessRole"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | AWS project account ARN |
| <a name="output_id"></a> [id](#output\_id) | AWS project account id |
| <a name="output_provider_config"></a> [provider\_config](#output\_provider\_config) | Terraform AWS provider block |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | IAM role ARN for root account administrators to manage the member account |
<!-- END_TF_DOCS -->

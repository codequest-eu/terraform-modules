# spa/middleware

`spa` internal module which creates a single Lambda@Edge function to be attached to a CloudFront distribution as middleware.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <0.16 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | >= 1.2.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_archive"></a> [archive](#provider\_archive) | >= 1.2.2 |
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.40.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_lambda_function.middleware](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [archive_file.archive](https://registry.terraform.io/providers/hashicorp/archive/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_code"></a> [code](#input\_code) | Lambda code | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_handler"></a> [handler](#input\_handler) | Path to the function which will handle lambda calls | `string` | `"index.handler"` | no |
| <a name="input_name"></a> [name](#input\_name) | Lambda name | `string` | n/a | yes |
| <a name="input_role_arn"></a> [role\_arn](#input\_role\_arn) | Role which should be assumed by the Lambda, created by middleware\_common module | `string` | n/a | yes |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Lambda runtime | `string` | `"nodejs10.x"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources that support them | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Lambda ARN |
<!-- END_TF_DOCS -->

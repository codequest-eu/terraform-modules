# cloudfront/lambda/basic_auth

Basic authentication function code for an AWS CloudFront Function

<!-- prettier-ignore-start -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <2.0 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_credentials"></a> [credentials](#input\_credentials) | Basic auth credentials | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_code"></a> [code](#output\_code) | Function code, including the signature |
| <a name="output_name"></a> [name](#output\_name) | Function name which can be used to invoke it |
<!-- END_TF_DOCS -->
<!-- prettier-ignore-end -->

# cloudfront/origin/s3

S3 origin factory for the `cloudfront` module

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket"></a> [bucket](#input\_bucket) | S3 bucket name. | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_headers"></a> [headers](#input\_headers) | Additional headers to pass to S3 | `map(string)` | `{}` | no |
| <a name="input_path"></a> [path](#input\_path) | Base S3 object path | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain"></a> [domain](#output\_domain) | S3 bucket domain |
| <a name="output_headers"></a> [headers](#output\_headers) | Additional headers to pass to S3 |
| <a name="output_path"></a> [path](#output\_path) | Base S3 object path |
<!-- END_TF_DOCS -->

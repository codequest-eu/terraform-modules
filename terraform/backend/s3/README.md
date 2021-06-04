# terraform/backend/s3

Creates resources needed to use a terraform S3 backend with locking

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <0.16 |
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
| [aws_dynamodb_table.state_lock](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/dynamodb_table) | resource |
| [aws_s3_bucket.state](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_force_destroy"></a> [bucket\_force\_destroy](#input\_bucket\_force\_destroy) | Allow destroying the state bucket even if it's not empty | `bool` | `false` | no |
| <a name="input_bucket_name"></a> [bucket\_name](#input\_bucket\_name) | State bucket name | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Whether any resources should be created | `bool` | `true` | no |
| <a name="input_lock_table_name"></a> [lock\_table\_name](#input\_lock\_table\_name) | DynamoDB lock table name, defaults to `{bucket}-lock` | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backend_config"></a> [backend\_config](#output\_backend\_config) | Terraform backend config map |
| <a name="output_backend_config_template"></a> [backend\_config\_template](#output\_backend\_config\_template) | Terraform backend block template |
| <a name="output_backend_type"></a> [backend\_type](#output\_backend\_type) | Terraform backend type |
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | State bucket ARN |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | State bucket name |
| <a name="output_lock_table_arn"></a> [lock\_table\_arn](#output\_lock\_table\_arn) | State lock table ARN |
| <a name="output_lock_table_name"></a> [lock\_table\_name](#output\_lock\_table\_name) | State lock table name |
| <a name="output_remote_state_template"></a> [remote\_state\_template](#output\_remote\_state\_template) | terraform\_remote\_state block template |
<!-- END_TF_DOCS -->

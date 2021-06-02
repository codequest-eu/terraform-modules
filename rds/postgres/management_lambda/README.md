# rds/postgres/management_lambda

Creates an AWS Lambda function which can be used to manage the RDS instance:

- create/drop users
- create/drop databases

## Contributing

Since it would be unreasonable to require a working installation of node.js on every machine that wants to apply the module, a compiled version of lambda's code is put in the `./dist` directory and included in the repository.

Remember to always run `npm run build` before committing any changes in `src`, so `src` and `dist` are kept in sync.

> **To do**
>
> Figure out a better way to handle this or at least add a CI step to verify `dist` is up-to-date.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.40.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda"></a> [lambda](#module\_lambda) | ./../../../lambda |  |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.lambda_egress_any](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_database_url"></a> [database\_url](#input\_database\_url) | Database URL with master credentials | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Lambda name | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Ids of subnets to place the lambda in | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources that support them | `map(string)` | `{}` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Id of the VPC to place the lambda in | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN identifying the Lambda Function |
| <a name="output_invoke_script"></a> [invoke\_script](#output\_invoke\_script) | Shell script for invoking the lambda using AWS CLI.<br>    Expects the event JSON to be passed via `$EVENT` environment variable.<br>    Useful for invoking the lambda during `terraform apply` using `null_resource`. |
| <a name="output_name"></a> [name](#output\_name) | The Lambda Function name |
| <a name="output_qualified_arn"></a> [qualified\_arn](#output\_qualified\_arn) | The ARN identifying the Lambda Function Version |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | Security group id |
<!-- END_TF_DOCS -->

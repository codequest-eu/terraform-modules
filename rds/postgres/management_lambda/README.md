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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda"></a> [lambda](#module\_lambda) | ./../../../lambda | n/a |
| <a name="module_package"></a> [package](#module\_package) | ./../../../zip | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_security_group.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.lambda_egress_any](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_database_url"></a> [database\_url](#input\_database\_url) | Database URL with master credentials | `string` | `null` | no |
| <a name="input_database_url_param"></a> [database\_url\_param](#input\_database\_url\_param) | AWS SSM parameter that holds database URL with master credentials | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Lambda name | `string` | n/a | yes |
| <a name="input_package_path"></a> [package\_path](#input\_package\_path) | Path where the lambda package will be created.<br>See `zip` `output_path` input for details. | `string` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Ids of subnets to place the lambda in, required when vpc is true | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources that support them | `map(string)` | `{}` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | Whether the lambda should be put in a VPC, required when RDS is in a private subnet. | `bool` | `false` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | Id of the VPC to place the lambda in, required when vpc is true | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN identifying the Lambda Function |
| <a name="output_name"></a> [name](#output\_name) | The Lambda Function name |
| <a name="output_qualified_arn"></a> [qualified\_arn](#output\_qualified\_arn) | The ARN identifying the Lambda Function Version |
| <a name="output_role_arn"></a> [role\_arn](#output\_role\_arn) | ARN of the role assumed by the lambda function |
| <a name="output_role_name"></a> [role\_name](#output\_role\_name) | Role assumed by the lambda function |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | Security group id, only available when vpc is true |
<!-- END_TF_DOCS -->
<!-- prettier-ignore-end -->

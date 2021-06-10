# lambda

Creates an AWS Lambda function

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
| <a name="module_package"></a> [package](#module\_package) | ./../zip | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_iam_role.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.basic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.vpc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_iam_policy_document.assume_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_assume_role_principals"></a> [assume\_role\_principals](#input\_assume\_role\_principals) | Which additional AWS services can assume the lambda role and invoke it | `list(string)` | `[]` | no |
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_environment_variables"></a> [environment\_variables](#input\_environment\_variables) | Environment variables | `map(string)` | `{}` | no |
| <a name="input_file_exclude_patterns"></a> [file\_exclude\_patterns](#input\_file\_exclude\_patterns) | **Deprecated. Use the `zip` module and `package_path` input instead.**<br><br>    Source code file exclusion patterns in case some unnecessary files are matched by `file_paths`. | `list(string)` | `[]` | no |
| <a name="input_file_patterns"></a> [file\_patterns](#input\_file\_patterns) | **Deprecated. Use the `zip` module and `package_path` input instead.**<br><br>    Source code file path patterns to narrow `files_dir` contents. | `list(string)` | <pre>[<br>  "**"<br>]</pre> | no |
| <a name="input_files"></a> [files](#input\_files) | **Deprecated. Use the `zip` module and `package_path` input instead.**<br><br>    Source code map. Either `files` or `files_dir` has to be specified | `map(string)` | `null` | no |
| <a name="input_files_dir"></a> [files\_dir](#input\_files\_dir) | **Deprecated. Use the `zip` module and `package_path` input instead.**<br><br>    Source code directory path. Either `files` or `files_dir` has to be specified | `string` | `null` | no |
| <a name="input_handler"></a> [handler](#input\_handler) | Path to the event handler | `string` | `"index.handler"` | no |
| <a name="input_layer_qualified_arns"></a> [layer\_qualified\_arns](#input\_layer\_qualified\_arns) | Lambda layers to include | `list(string)` | `[]` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | Amount of memory in MB your Lambda Function can use at runtime | `number` | `128` | no |
| <a name="input_name"></a> [name](#input\_name) | Lambda name | `string` | n/a | yes |
| <a name="input_package_path"></a> [package\_path](#input\_package\_path) | Path to the zip that contains the Lambda's source. Either `package_path` or `package_s3` is required. | `string` | `null` | no |
| <a name="input_package_s3"></a> [package\_s3](#input\_package\_s3) | S3 zip object that contains the Lambda's source. Either `package_path` or `package_s3` is required. | <pre>object({<br>    bucket = string<br>    key    = string<br>  })</pre> | `null` | no |
| <a name="input_package_s3_version"></a> [package\_s3\_version](#input\_package\_s3\_version) | Version number of the S3 object to use | `string` | `null` | no |
| <a name="input_policy_arns"></a> [policy\_arns](#input\_policy\_arns) | Additional policy ARNs to attach to the Lambda role | `map(string)` | `{}` | no |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | [Runtime](https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html#SSS-CreateFunction-request-Runtime) | `string` | `"nodejs12.x"` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Security groups to assign | `list(string)` | `null` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnet ids to place the lambda in | `list(string)` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to set on resources that support them | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | The amount of time your Lambda Function has to run in seconds | `number` | `60` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN identifying the Lambda Function |
| <a name="output_invoke_arn"></a> [invoke\_arn](#output\_invoke\_arn) | The ARN to be used for invoking Lambda Function from API Gateway |
| <a name="output_metrics"></a> [metrics](#output\_metrics) | Cloudwatch monitoring metrics |
| <a name="output_name"></a> [name](#output\_name) | The Lambda Function name |
| <a name="output_qualified_arn"></a> [qualified\_arn](#output\_qualified\_arn) | The ARN identifying the Lambda Function Version |
| <a name="output_version"></a> [version](#output\_version) | Latest published version of the Lambda Function |
| <a name="output_widgets"></a> [widgets](#output\_widgets) | Cloudwatch dashboard widgets |
<!-- END_TF_DOCS -->

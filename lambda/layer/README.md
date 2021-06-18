# lambda/layer

Creates an AWS Lambda Layer that can be attached to a AWS Lambda Function

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
| <a name="module_package"></a> [package](#module\_package) | ./../../zip | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_lambda_layer_version.layer](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_layer_version) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_file_exclude_patterns"></a> [file\_exclude\_patterns](#input\_file\_exclude\_patterns) | **Deprecated. Use the `zip` module and `package_path` input instead.**<br><br>    Source code file exclusion patterns in case some unnecessary files are matched by `file_paths`. | `list(string)` | `[]` | no |
| <a name="input_file_patterns"></a> [file\_patterns](#input\_file\_patterns) | **Deprecated. Use the `zip` module and `package_path` input instead.**<br><br>    Source code file path patterns to narrow `files_dir` contents. | `list(string)` | <pre>[<br>  "**"<br>]</pre> | no |
| <a name="input_files"></a> [files](#input\_files) | **Deprecated. Use the `zip` module and `package_path` input instead.**<br><br>    Source code map. Either `files` or `files_dir` has to be specified | `map(string)` | `null` | no |
| <a name="input_files_dir"></a> [files\_dir](#input\_files\_dir) | **Deprecated. Use the `zip` module and `package_path` input instead.**<br><br>    Source code directory path. Either `files` or `files_dir` has to be specified | `string` | `null` | no |
| <a name="input_files_output_path"></a> [files\_output\_path](#input\_files\_output\_path) | **Deprecated. Use the `zip` module and `package_path` input instead.**<br><br>Path where the layer package will be created when using `files` or `files_dir`.<br>See `zip` `output_path` input for details. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Lambda layer name | `string` | n/a | yes |
| <a name="input_package_path"></a> [package\_path](#input\_package\_path) | Path to the zip that contains the Lambda layer's source. Either `package_path`, `package_s3` or `image` is required. | `string` | `null` | no |
| <a name="input_package_s3"></a> [package\_s3](#input\_package\_s3) | S3 zip object that contains the Lambda layer's source. Either `package_path` or `package_s3` is required. | <pre>object({<br>    bucket = string<br>    key    = string<br>  })</pre> | `null` | no |
| <a name="input_package_s3_version"></a> [package\_s3\_version](#input\_package\_s3\_version) | Version number of the S3 object to use | `string` | `null` | no |
| <a name="input_runtimes"></a> [runtimes](#input\_runtimes) | [Runtimes](https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html#SSS-CreateFunction-request-Runtime) compatible with this lambda layer | `list(string)` | <pre>[<br>  "nodejs12.x"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN identifying the Lambda Layer |
| <a name="output_name"></a> [name](#output\_name) | The Lambda Layer name |
| <a name="output_qualified_arn"></a> [qualified\_arn](#output\_qualified\_arn) | The ARN identifying the Lambda Layer Version |
| <a name="output_version"></a> [version](#output\_version) | Latest published version of the Lambda Layer |
<!-- END_TF_DOCS -->
<!-- prettier-ignore-end -->

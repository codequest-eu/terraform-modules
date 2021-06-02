# cloudfront/lambda

AWS Lambda middleware for AWS CloudFront

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <0.14 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | >= 1.2.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.40.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda"></a> [lambda](#module\_lambda) | ./../../lambda |  |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_code"></a> [code](#input\_code) | Lambda code | `string` | n/a | yes |
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_handler"></a> [handler](#input\_handler) | Path to the function which will handle lambda calls | `string` | `"index.handler"` | no |
| <a name="input_include_body"></a> [include\_body](#input\_include\_body) | Whether the lambda requires viewer/origin request body | `bool` | `false` | no |
| <a name="input_name"></a> [name](#input\_name) | Lambda name | `string` | n/a | yes |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | Lambda runtime | `string` | `"nodejs12.x"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources that support them | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | The amount of time your Lambda Function has to run in seconds.<br><br>    Maximum of 5 for viewer events, 30 for origin events.<br>    https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/lambda-requirements-limits.html#lambda-requirements-see-limits | `number` | `5` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Lambda ARN |
| <a name="output_include_body"></a> [include\_body](#output\_include\_body) | Whether cloudfront should include the viewer/origin request body |
| <a name="output_metrics"></a> [metrics](#output\_metrics) | Cloudwatch monitoring metrics |
| <a name="output_widgets"></a> [widgets](#output\_widgets) | Cloudwatch dashboard widgets |
<!-- END_TF_DOCS -->

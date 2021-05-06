# lambda/trigger/schedule

Sets up lambda triggering on schedule using a Cloudwatch event rule.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
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
| [aws_cloudwatch_event_rule.rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_rule) | resource |
| [aws_cloudwatch_event_target.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_event_target) | resource |
| [aws_lambda_permission.rule_invoke](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_permission) | resource |
| [aws_arn.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/arn) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Description for the Cloudwatch event rule | `string` | `null` | no |
| <a name="input_lambda_arn"></a> [lambda\_arn](#input\_lambda\_arn) | ARN of the Lambda function that should be triggered | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Name of the Cloudwatch event rule to create | `string` | n/a | yes |
| <a name="input_schedule"></a> [schedule](#input\_schedule) | Schedule expression when the Lambda should be triggered,<br>    see [scheduled events](https://docs.aws.amazon.com/AmazonCloudWatch/latest/events/ScheduledEvents.html)<br>    for details | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to set on resources that support them | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rule_arn"></a> [rule\_arn](#output\_rule\_arn) | Cloudwatch event rule ARN |
| <a name="output_rule_name"></a> [rule\_name](#output\_rule\_name) | Cloudwatch event rule name |
<!-- END_TF_DOCS -->

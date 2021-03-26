# cloudwatch/alarm

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_metric_alarm.alarm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_metric_alarm) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_condition"></a> [condition](#input\_condition) | Alarm trigger condition as a `[metric_id, operator, threshold]` tuple, eg. `['m1', '<', 0]`.<br><br>    Supported operators:<br><br>    \|\|\|<br>    \|-\|-\|<br>    \| `<` \| `LessThanThreshold` or `LessThanLowerThreshold` \|<br>    \| `<=` \| `LessThanOrEqualToThreshold` \|<br>    \| `>` \| `GreaterThanThreshold` or `GreaterThanUpperThreshold` \|<br>    \| `>=` \| `GreaterThanOrEqualToThreshold` \|<br>    \| `<>` \| `LessThanLowerOrGreaterThanUpperThreshold` \|<br><br>    For anomaly detection `threshold` should be the id of the `ANOMALY_DETECTION_BAND` function. | `tuple([string, string, any])` | n/a | yes |
| <a name="input_condition_period"></a> [condition\_period](#input\_condition\_period) | How many (N) periods have to meet the condition within the last M periods<br>to trigger the alarm, as a `[N, M]` tuple,<br>eg. `[3, 4]` will require the condition to be met at least 3 times in the last 4 periods | `tuple([number, number])` | <pre>[<br>  1,<br>  1<br>]</pre> | no |
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Alarm description | `string` | `""` | no |
| <a name="input_metrics"></a> [metrics](#input\_metrics) | Metrics used by the alarm condition | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Alarm name | `string` | n/a | yes |
| <a name="input_no_data_actions"></a> [no\_data\_actions](#input\_no\_data\_actions) | ARNs of actions that should be triggered when there's missing data | `list(string)` | `[]` | no |
| <a name="input_no_data_behavior"></a> [no\_data\_behavior](#input\_no\_data\_behavior) | What to do with missing data, one of 'missing', 'ignore', 'breaching', 'notBreaching' | `string` | `"missing"` | no |
| <a name="input_off_actions"></a> [off\_actions](#input\_off\_actions) | ARNs of actions that should be triggered when the alarm goes off | `list(string)` | `[]` | no |
| <a name="input_on_actions"></a> [on\_actions](#input\_on\_actions) | ARNs of actions that should be triggered when the alarm goes on | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources that support them | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Alarm ARN |
| <a name="output_id"></a> [id](#output\_id) | Alarm healthcheck id |
| <a name="output_name"></a> [name](#output\_name) | Alarm name |
<!-- END_TF_DOCS -->

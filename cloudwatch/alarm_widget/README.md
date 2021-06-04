# cloudwatch/alarm_widget

Prepares an alarm widget object for `cloudwatch/dashboard`

https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/CloudWatch-Dashboard-Body-Structure.html#CloudWatch-Dashboard-Properties-Widgets-Structure

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <0.16 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alarm_arn"></a> [alarm\_arn](#input\_alarm\_arn) | ARN of the alarm to display | `string` | n/a | yes |
| <a name="input_dimensions"></a> [dimensions](#input\_dimensions) | Dimensions of the widget | `tuple([number, number])` | <pre>[<br>  6,<br>  6<br>]</pre> | no |
| <a name="input_position"></a> [position](#input\_position) | Position of the widget | `tuple([number, number])` | `null` | no |
| <a name="input_range"></a> [range](#input\_range) | Minimum and maximum values to display on the Y axis | `tuple([number, number])` | <pre>[<br>  null,<br>  null<br>]</pre> | no |
| <a name="input_stacked"></a> [stacked](#input\_stacked) | Enable the stacked metrics layout | `bool` | `false` | no |
| <a name="input_title"></a> [title](#input\_title) | Widget title | `string` | n/a | yes |
| <a name="input_view"></a> [view](#input\_view) | Widget view, either timeSeries or singleValue | `string` | `"timeSeries"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dimensions"></a> [dimensions](#output\_dimensions) | Widget dimensions |
| <a name="output_position"></a> [position](#output\_position) | Widget position |
| <a name="output_properties"></a> [properties](#output\_properties) | Widget properties |
| <a name="output_type"></a> [type](#output\_type) | Widget type |
<!-- END_TF_DOCS -->

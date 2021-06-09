# cloudwatch/metric_widget

Prepares a metric widget object for `cloudwatch/dashboard`

https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/CloudWatch-Dashboard-Body-Structure.html#CloudWatch-Dashboard-Properties-Widgets-Structure

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <0.13 |
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
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dimensions"></a> [dimensions](#input\_dimensions) | Dimensions of the widget | `tuple([number, number])` | <pre>[<br>  6,<br>  6<br>]</pre> | no |
| <a name="input_hidden_metrics"></a> [hidden\_metrics](#input\_hidden\_metrics) | Metrics used in expressions | `any` | `[]` | no |
| <a name="input_left_annotations"></a> [left\_annotations](#input\_left\_annotations) | Horizontal annotations to display on the widget's left Y axis | `any` | `[]` | no |
| <a name="input_left_metrics"></a> [left\_metrics](#input\_left\_metrics) | Metrics to display on the widget's left Y axis | `any` | `[]` | no |
| <a name="input_left_range"></a> [left\_range](#input\_left\_range) | Minimum and maximum values to display on the left Y axis | `tuple([number, number])` | <pre>[<br>  null,<br>  null<br>]</pre> | no |
| <a name="input_position"></a> [position](#input\_position) | Position of the widget | `tuple([number, number])` | `null` | no |
| <a name="input_right_annotations"></a> [right\_annotations](#input\_right\_annotations) | Horizontal annotations to display on the widget's right Y axis | `any` | `[]` | no |
| <a name="input_right_metrics"></a> [right\_metrics](#input\_right\_metrics) | Metrics to display on the widget's right Y axis | `any` | `[]` | no |
| <a name="input_right_range"></a> [right\_range](#input\_right\_range) | Minimum and maximum values to display on the right Y axis | `tuple([number, number])` | <pre>[<br>  null,<br>  null<br>]</pre> | no |
| <a name="input_stacked"></a> [stacked](#input\_stacked) | Enable the stacked metrics layout | `bool` | `false` | no |
| <a name="input_title"></a> [title](#input\_title) | Widget title | `string` | n/a | yes |
| <a name="input_vertical_annotations"></a> [vertical\_annotations](#input\_vertical\_annotations) | Vertical annotations to display | `any` | `[]` | no |
| <a name="input_view"></a> [view](#input\_view) | Widget view, either timeSeries or singleValue | `string` | `"timeSeries"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dimensions"></a> [dimensions](#output\_dimensions) | Widget dimensions |
| <a name="output_position"></a> [position](#output\_position) | Widget position |
| <a name="output_properties"></a> [properties](#output\_properties) | Widget properties |
| <a name="output_type"></a> [type](#output\_type) | Widget type |
<!-- END_TF_DOCS -->

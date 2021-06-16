# cloudwatch/metric

<!-- prettier-ignore-start -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <2.0 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_color"></a> [color](#input\_color) | Color to use in graphs | `string` | `null` | no |
| <a name="input_dimensions"></a> [dimensions](#input\_dimensions) | Additional metric filters, eg. `{ InstanceId = i-abc123 }` | `map(string)` | `{}` | no |
| <a name="input_label"></a> [label](#input\_label) | Human-friendly metric description | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the metric, eg. `CPUUtilization` | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Namespace of the metric, eg. `AWS/EC2` | `string` | n/a | yes |
| <a name="input_period"></a> [period](#input\_period) | Metric aggregation period in seconds | `number` | `60` | no |
| <a name="input_stat"></a> [stat](#input\_stat) | Metric aggregation function | `string` | `"Average"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_color"></a> [color](#output\_color) | Metric color to use in graphs |
| <a name="output_dimensions"></a> [dimensions](#output\_dimensions) | Additional metric filters, eg. `{ InstanceId = i-abc123 }` |
| <a name="output_id"></a> [id](#output\_id) | Metric id to use in expressions |
| <a name="output_label"></a> [label](#output\_label) | Human-friendly metric description |
| <a name="output_name"></a> [name](#output\_name) | Name of the metric, eg. `CPUUtilization` |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | Namespace of the metric, eg. `AWS/EC2` |
| <a name="output_period"></a> [period](#output\_period) | Metric aggregation period in seconds |
| <a name="output_stat"></a> [stat](#output\_stat) | Metric aggregation function |
<!-- END_TF_DOCS -->
<!-- prettier-ignore-end -->

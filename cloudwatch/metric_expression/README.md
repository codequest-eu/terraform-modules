# cloudwatch/metric_expression

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <0.15 |

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
| <a name="input_expression"></a> [expression](#input\_expression) | Metric expression, eg. 'm1 + m2' | `string` | n/a | yes |
| <a name="input_label"></a> [label](#input\_label) | Human-friendly metric description | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_color"></a> [color](#output\_color) | Metric color to use in graphs |
| <a name="output_expression"></a> [expression](#output\_expression) | Metric expression, eg. 'm1 + m2' |
| <a name="output_id"></a> [id](#output\_id) | Metric id to use in expressions |
| <a name="output_label"></a> [label](#output\_label) | Human-friendly metric description |
<!-- END_TF_DOCS -->

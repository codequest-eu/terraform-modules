# cloudwatch/annotation

Prepares an annotation structure for widget modules.

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_color"></a> [color](#input\_color) | Annotation color | `string` | `null` | no |
| <a name="input_fill"></a> [fill](#input\_fill) | Fill mode, one of (horizontal/vertical): `above`/`after`, `below`/`before`, `none` | `string` | `"none"` | no |
| <a name="input_label"></a> [label](#input\_label) | Annotation label | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Band annotation labels for minimum/start and maximum/end lines | `tuple([string, string])` | `null` | no |
| <a name="input_time"></a> [time](#input\_time) | Vertical annotation timestamp | `string` | `null` | no |
| <a name="input_time_range"></a> [time\_range](#input\_time\_range) | Vertical band annotation start and end timestamps | `tuple([string, string])` | `null` | no |
| <a name="input_value"></a> [value](#input\_value) | Horizontal annotation value | `number` | `null` | no |
| <a name="input_value_range"></a> [value\_range](#input\_value\_range) | Horizontal band annotation minimum and maximum values | `tuple([number, number])` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_body"></a> [body](#output\_body) | Annotation structure used by widget modules |
| <a name="output_is_band"></a> [is\_band](#output\_is\_band) | Whether this is a band annotation |
| <a name="output_is_horizontal"></a> [is\_horizontal](#output\_is\_horizontal) | Whether this is a horizontal annotation |
| <a name="output_is_vertical"></a> [is\_vertical](#output\_is\_vertical) | Whether this is a vertical annotation |
<!-- END_TF_DOCS -->

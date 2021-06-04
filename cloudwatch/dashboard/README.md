# cloudwatch/dashboard

Creates a dashboard in cloudwatch with the given widgets.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <0.16 |
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
| [aws_cloudwatch_dashboard.dashboard](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_dashboard) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_end"></a> [end](#input\_end) | The end of the time range to use for each widget on the dashboard.<br>    Has to be an ISO 8601 timestamp, eg. `2020-01-01T00:00:00.000Z`.<br>    If specified, `start` also has to be a timestamp. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the dashboard | `string` | n/a | yes |
| <a name="input_period_override"></a> [period\_override](#input\_period\_override) | Specifies the period for the graphs when the dashboard loads, either `auto` or `inherit` | `string` | `"auto"` | no |
| <a name="input_start"></a> [start](#input\_start) | The start of the time range to use for each widget on the dashboard.<br>    Can be either a relative value, eg. `-PT5M` for last 5 minutes, `-PT7D` for last 7 days,<br>    or an ISO 8601 timestamp, eg. `2020-01-01T00:00:00.000Z` | `string` | `null` | no |
| <a name="input_widgets"></a> [widgets](#input\_widgets) | Widgets to place on the dashboard | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Dashboard ARN |
| <a name="output_name"></a> [name](#output\_name) | Dashboard name |
| <a name="output_url"></a> [url](#output\_url) | Dashboard URL |
<!-- END_TF_DOCS -->

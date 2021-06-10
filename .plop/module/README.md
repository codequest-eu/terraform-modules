# {{ path }}

<!-- TODO: {{ path }} description -->

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.40.0 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether any resources should be created | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_metrics"></a> [metrics](#output\_metrics) | Cloudwatch monitoring metrics |
| <a name="output_widgets"></a> [widgets](#output\_widgets) | Cloudwatch dashboard widgets |
<!-- END_TF_DOCS -->

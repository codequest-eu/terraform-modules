# cloudwatch/metric_expression/many

Same as [cloudwatch/metric_expression](./..) but allows for creating many metrics using a single module

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <0.14 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_default"></a> [default](#module\_default) | ./.. |  |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_vars"></a> [vars](#input\_vars) | List of [cloudwatch/metric\_expression](./..) variables | `any` | `[]` | no |
| <a name="input_vars_map"></a> [vars\_map](#input\_vars\_map) | Map of [cloudwatch/metric\_expression](./..) variables | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_out"></a> [out](#output\_out) | List of [cloudwatch/metric\_expression](./..) outputs |
| <a name="output_out_map"></a> [out\_map](#output\_out\_map) | Map of [cloudwatch/metric\_expression](./..) outputs |
<!-- END_TF_DOCS -->

# cloudfront/origin/http

HTTPS origin factory for the `cloudfront` module

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |

## Providers

No providers.

## Modules

No modules.

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | Domain where the origin is hosted | `string` | n/a | yes |
| <a name="input_headers"></a> [headers](#input\_headers) | Additional headers to pass to the origin | `map(string)` | `{}` | no |
| <a name="input_path"></a> [path](#input\_path) | Path where the origin is hosted | `string` | `""` | no |
| <a name="input_port"></a> [port](#input\_port) | Port on which the origin listens for HTTP/HTTPS requests | `number` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_domain"></a> [domain](#output\_domain) | Domain where the origin is hosted |
| <a name="output_headers"></a> [headers](#output\_headers) | Additional headers to pass to the origin |
| <a name="output_path"></a> [path](#output\_path) | Path where the origin is hosted |
| <a name="output_port"></a> [port](#output\_port) | Port on which the origin listens for HTTP/HTTPS requests |
<!-- END_TF_DOCS -->

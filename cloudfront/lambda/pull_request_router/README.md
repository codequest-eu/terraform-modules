# cloudfront/lambda/basic_auth

Pull request router for AWS CloudFront. Serves the right `index.html` based on a path prefix, by default `/PR-#/`. Useful for SPA preview environments.

<!-- prettier-ignore-start -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <2.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_middleware"></a> [middleware](#module\_middleware) | ./.. | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_name"></a> [name](#input\_name) | Lambda name | `string` | n/a | yes |
| <a name="input_package_path"></a> [package\_path](#input\_package\_path) | Path where the lambda package will be created.<br>See `zip` `output_path` input for details. | `string` | `null` | no |
| <a name="input_path_re"></a> [path\_re](#input\_path\_re) | Regular expression which extracts the base directory of a PR as it's first match group | `string` | `"^/(PR-\\d+)($|/)"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources that support them | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Lambda ARN |
| <a name="output_include_body"></a> [include\_body](#output\_include\_body) | Whether cloudfront should include the viewer/origin request body |
| <a name="output_metrics"></a> [metrics](#output\_metrics) | Cloudwatch monitoring metrics |
| <a name="output_widgets"></a> [widgets](#output\_widgets) | Cloudwatch dashboard widgets |
<!-- END_TF_DOCS -->
<!-- prettier-ignore-end -->

# cloudfront/lambda/response_headers

Cloudfront origin response lambda which adds the specified headers to cloudfront responses.

Based on https://aws.amazon.com/blogs/networking-and-content-delivery/adding-http-security-headers-using-lambdaedge-and-amazon-cloudfront/

## Cloudfront invalidation

If you attach this lambda to the origin response hook keep in mind that cloudfront will only send requests to the origin (and call the lambda) if it doesn't already have the resource cached. This means that you won't see changes to response headers for cached paths. You will need to manually invalidate the cloudfront cache for changes to take effect.

Consult the [example](../../examples/response_headers) for how it could be done by terraform using a `null_resource` which uses AWS CLI to invalidate the cache whenever the lambda version changes.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lambda"></a> [lambda](#module\_lambda) | ./../../../lambda |  |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_global"></a> [global](#input\_global) | Headers to add to all responses | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Lambda name | `string` | n/a | yes |
| <a name="input_rules"></a> [rules](#input\_rules) | Rules for adding headers to some responses.<br><br>    Both `path` and `content_type` support glob patterns using [micromatch](https://github.com/micromatch/micromatch#matching-features). | <pre>list(object({<br>    path         = string<br>    content_type = string<br>    headers      = map(string)<br>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources that support them | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Lambda ARN |
| <a name="output_include_body"></a> [include\_body](#output\_include\_body) | Whether cloudfront should include the viewer/origin request body |
| <a name="output_metrics"></a> [metrics](#output\_metrics) | Cloudwatch monitoring metrics |
| <a name="output_widgets"></a> [widgets](#output\_widgets) | Cloudwatch dashboard widgets |
<!-- END_TF_DOCS -->

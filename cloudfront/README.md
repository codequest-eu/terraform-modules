# cloudfront

AWS Cloudfront distribution

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <2.0 |
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
| [aws_cloudfront_distribution.distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_identity.distribution](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_behaviors"></a> [behaviors](#input\_behaviors) | Path specific caching behaviors | <pre>map(object({<br>    path            = string<br>    allowed_methods = list(string)<br><br>    cached_methods    = list(string)<br>    cached_headers    = list(string)<br>    cached_cookies    = list(string)<br>    cached_query_keys = list(string)<br><br>    origin_id     = string<br>    compress      = bool<br>    forward_query = bool<br><br>    viewer_request_lambda  = object({ arn = string, include_body = bool })<br>    origin_request_lambda  = object({ arn = string, include_body = bool })<br>    origin_response_lambda = object({ arn = string })<br>    viewer_response_lambda = object({ arn = string })<br>  }))</pre> | `{}` | no |
| <a name="input_behaviors_order"></a> [behaviors\_order](#input\_behaviors\_order) | Order in which behaviors should be resolved. Defaults to behaviors map order. | `list(string)` | `null` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | ACM certificate ARN to use instead of the default cloudfront certificate. Has to cover all specified `domains`. | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Whether any resources should be created | `bool` | `true` | no |
| <a name="input_default_behavior"></a> [default\_behavior](#input\_default\_behavior) | Default caching behavior | <pre>object({<br>    allowed_methods = list(string)<br><br>    cached_methods    = list(string)<br>    cached_headers    = list(string)<br>    cached_cookies    = list(string)<br>    cached_query_keys = list(string)<br><br>    origin_id     = string<br>    compress      = bool<br>    forward_query = bool<br><br>    viewer_request_lambda  = object({ arn = string, include_body = bool })<br>    origin_request_lambda  = object({ arn = string, include_body = bool })<br>    origin_response_lambda = object({ arn = string })<br>    viewer_response_lambda = object({ arn = string })<br>  })</pre> | n/a | yes |
| <a name="input_domains"></a> [domains](#input\_domains) | List of domains which will serve the application. If empty, will use the default cloudfront domain | `list(string)` | `[]` | no |
| <a name="input_error_responses"></a> [error\_responses](#input\_error\_responses) | Custom error responses | <pre>map(object({<br>    response_code = number<br>    response_path = string<br>  }))</pre> | `{}` | no |
| <a name="input_http_origins"></a> [http\_origins](#input\_http\_origins) | HTTP origins proxied by this distribution | <pre>map(object({<br>    domain  = string<br>    path    = string<br>    headers = map(string)<br>    port    = number<br>  }))</pre> | `{}` | no |
| <a name="input_https_origins"></a> [https\_origins](#input\_https\_origins) | HTTPS origins proxied by this distribution | <pre>map(object({<br>    domain  = string<br>    path    = string<br>    headers = map(string)<br>    port    = number<br>  }))</pre> | `{}` | no |
| <a name="input_price_class"></a> [price\_class](#input\_price\_class) | CloudFront price class, which specifies where the distribution should be replicated, one of: PriceClass\_100, PriceClass\_200, PriceClass\_All | `string` | `"PriceClass_100"` | no |
| <a name="input_s3_origins"></a> [s3\_origins](#input\_s3\_origins) | AWS S3 buckets proxied by this distribution | <pre>map(object({<br>    domain  = string<br>    path    = string<br>    headers = map(string)<br>  }))</pre> | `{}` | no |
| <a name="input_ssl_policy"></a> [ssl\_policy](#input\_ssl\_policy) | Cloudfront SSL policy, used only when `certificate_arn` is provided. See https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/secure-connections-supported-viewer-protocols-ciphers.html | `string` | `"TLSv1.2_2019"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_identity_arn"></a> [access\_identity\_arn](#output\_access\_identity\_arn) | A pre-generated access identity ARN for use in S3 bucket policies. |
| <a name="output_access_identity_id"></a> [access\_identity\_id](#output\_access\_identity\_id) | Access identity id for the distribution. For example: EDFDVBD632BHDS5. |
| <a name="output_arn"></a> [arn](#output\_arn) | ARN of the distribution |
| <a name="output_domain"></a> [domain](#output\_domain) | Domain of the distribution, eg. d604721fxaaqy9.cloudfront.net. |
| <a name="output_id"></a> [id](#output\_id) | ID of the distribution |
| <a name="output_metrics"></a> [metrics](#output\_metrics) | Cloudwatch monitoring metrics |
| <a name="output_url"></a> [url](#output\_url) | URL of the distribution, eg. https://d604721fxaaqy9.cloudfront.net. |
| <a name="output_widgets"></a> [widgets](#output\_widgets) | Cloudwatch dashboard widgets |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | Route 53 zone ID that can be used to route an Alias Resource Record Set to. |
<!-- END_TF_DOCS -->

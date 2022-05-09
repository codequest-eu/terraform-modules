# cloudfront/behavior

Behavior factory for the `cloudfront` module

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
| <a name="input_allowed_methods"></a> [allowed\_methods](#input\_allowed\_methods) | HTTP methods forwarded to the origin | `list(string)` | <pre>[<br>  "GET",<br>  "HEAD",<br>  "OPTIONS"<br>]</pre> | no |
| <a name="input_cached_cookies"></a> [cached\_cookies](#input\_cached\_cookies) | Which cookies should be forwarded to the origin and included in the cache key. Pass `["*"]` to forward all cookies. | `list(string)` | `[]` | no |
| <a name="input_cached_headers"></a> [cached\_headers](#input\_cached\_headers) | Which headers should be forwarded to the origin and included in the cache key. Pass `["*"]` to forward all headers. | `list(string)` | `[]` | no |
| <a name="input_cached_methods"></a> [cached\_methods](#input\_cached\_methods) | HTTP methods that should be cached | `list(string)` | <pre>[<br>  "GET",<br>  "HEAD",<br>  "OPTIONS"<br>]</pre> | no |
| <a name="input_cached_query_keys"></a> [cached\_query\_keys](#input\_cached\_query\_keys) | Which URL query keys should be included in the cache key. Requires `forward_query = true`. Specify `["*"]` to include all query keys. | `list(string)` | `[]` | no |
| <a name="input_compress"></a> [compress](#input\_compress) | Whether to compress origin responses using gzip. | `bool` | `true` | no |
| <a name="input_default_ttl"></a> [default\_ttl](#input\_default\_ttl) | Default number of seconds to cache objects for, can be overriden with the Cache-Control header | `number` | `0` | no |
| <a name="input_forward_query"></a> [forward\_query](#input\_forward\_query) | Whether to forward the URL query to the origin. | `bool` | `false` | no |
| <a name="input_max_ttl"></a> [max\_ttl](#input\_max\_ttl) | Maximum number of seconds to cache objects for, defaults to 1 year | `number` | `31536000` | no |
| <a name="input_min_ttl"></a> [min\_ttl](#input\_min\_ttl) | Minimum number of seconds to cache objects for | `number` | `0` | no |
| <a name="input_origin_id"></a> [origin\_id](#input\_origin\_id) | Id of the origin that requests will be forwarded to. | `string` | n/a | yes |
| <a name="input_origin_request_lambda"></a> [origin\_request\_lambda](#input\_origin\_request\_lambda) | Lambda function to invoke before CloudFront sends a request to the origin | `object({ arn = string, include_body = bool })` | `null` | no |
| <a name="input_origin_response_lambda"></a> [origin\_response\_lambda](#input\_origin\_response\_lambda) | Lambda function to invoke when CloudFront receives a response from origin | `object({ arn = string })` | `null` | no |
| <a name="input_path"></a> [path](#input\_path) | Path the behavior should apply to | `string` | `null` | no |
| <a name="input_viewer_request_function_arn"></a> [viewer\_request\_function\_arn](#input\_viewer\_request\_function\_arn) | CloudFront function ARN to invoke when CloudFront receives a request | `string` | `null` | no |
| <a name="input_viewer_request_lambda"></a> [viewer\_request\_lambda](#input\_viewer\_request\_lambda) | Lambda function to invoke when CloudFront receives a request | `object({ arn = string, include_body = bool })` | `null` | no |
| <a name="input_viewer_response_function_arn"></a> [viewer\_response\_function\_arn](#input\_viewer\_response\_function\_arn) | CloudFront function ARN to invoke before CloudFront returns a response | `string` | `null` | no |
| <a name="input_viewer_response_lambda"></a> [viewer\_response\_lambda](#input\_viewer\_response\_lambda) | Lambda function to invoke before CloudFront returns a response | `object({ arn = string })` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_allowed_methods"></a> [allowed\_methods](#output\_allowed\_methods) | HTTP methods forwarded to the origin |
| <a name="output_cached_cookies"></a> [cached\_cookies](#output\_cached\_cookies) | Which cookies should be forwarded to the origin and included in the cache key. Pass `["*"]` to forward all cookies. |
| <a name="output_cached_headers"></a> [cached\_headers](#output\_cached\_headers) | Which headers should be forwarded to the origin and included in the cache key. Pass `["*"]` to forward all headers. |
| <a name="output_cached_methods"></a> [cached\_methods](#output\_cached\_methods) | HTTP methods that should be cached |
| <a name="output_cached_query_keys"></a> [cached\_query\_keys](#output\_cached\_query\_keys) | Which URL query keys should be included in the cache key. Requires `forward_query = true`. Specify `["*"]` to include all query keys. |
| <a name="output_compress"></a> [compress](#output\_compress) | Whether to compress origin responses using gzip. |
| <a name="output_default_ttl"></a> [default\_ttl](#output\_default\_ttl) | Default number of seconds to cache objects for |
| <a name="output_forward_query"></a> [forward\_query](#output\_forward\_query) | Whether to forward the URL query to the origin. |
| <a name="output_max_ttl"></a> [max\_ttl](#output\_max\_ttl) | Maximum number of seconds to cache objects for |
| <a name="output_min_ttl"></a> [min\_ttl](#output\_min\_ttl) | Minimum number of seconds to cache objects for |
| <a name="output_origin_id"></a> [origin\_id](#output\_origin\_id) | Id of the origin that requests will be forwarded to. |
| <a name="output_origin_request_lambda"></a> [origin\_request\_lambda](#output\_origin\_request\_lambda) | Lambda function to invoke before CloudFront sends a request to the origin |
| <a name="output_origin_response_lambda"></a> [origin\_response\_lambda](#output\_origin\_response\_lambda) | Lambda function to invoke when CloudFront receives a response from origin |
| <a name="output_path"></a> [path](#output\_path) | Path the behavior should apply to |
| <a name="output_viewer_request_function_arn"></a> [viewer\_request\_function\_arn](#output\_viewer\_request\_function\_arn) | CloudFront function ARN to invoke when CloudFront receives a request |
| <a name="output_viewer_request_lambda"></a> [viewer\_request\_lambda](#output\_viewer\_request\_lambda) | Lambda function to invoke when CloudFront receives a request |
| <a name="output_viewer_response_function_arn"></a> [viewer\_response\_function\_arn](#output\_viewer\_response\_function\_arn) | CloudFront function ARN to invoke before CloudFront returns a response |
| <a name="output_viewer_response_lambda"></a> [viewer\_response\_lambda](#output\_viewer\_response\_lambda) | Lambda function to invoke before CloudFront returns a response |
<!-- END_TF_DOCS -->
<!-- prettier-ignore-end -->

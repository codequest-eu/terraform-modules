# cloudfront/behavior

Behavior factory for the `cloudfront` module

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |

## Inputs

* `allowed_methods` (`list(string)`, default: `["GET","HEAD","OPTIONS"]`)

    HTTP methods forwarded to the origin

* `cached_cookies` (`list(string)`, default: `[]`)

    Which cookies should be forwarded to the origin and included in the cache key. Pass `["*"]` to forward all cookies.

* `cached_headers` (`list(string)`, default: `[]`)

    Which headers should be forwarded to the origin and included in the cache key. Pass `["*"]` to forward all headers.

* `cached_methods` (`list(string)`, default: `["GET","HEAD","OPTIONS"]`)

    HTTP methods that should be cached

* `cached_query_keys` (`list(string)`, default: `[]`)

    Which URL query keys should be included in the cache key. Requires `forward_query = true`. Specify `["*"]` to include all query keys.

* `compress` (`bool`, default: `true`)

    Whether to compress origin responses using gzip.

* `forward_query` (`bool`, default: `false`)

    Whether to forward the URL query to the origin.

* `origin_id` (`string`, required)

    Id of the origin that requests will be forwarded to.

* `origin_request_lambda` (`object({ arn = string, include_body = bool })`, default: `null`)

    Lambda function to invoke before CloudFront sends a request to the origin

* `origin_response_lambda` (`object({ arn = string })`, default: `null`)

    Lambda function to invoke when CloudFront receives a response from origin

* `path` (`string`, default: `null`)

    Path the behavior should apply to

* `viewer_request_lambda` (`object({ arn = string, include_body = bool })`, default: `null`)

    Lambda function to invoke when CloudFront receives a request

* `viewer_response_lambda` (`object({ arn = string })`, default: `null`)

    Lambda function to invoke before CloudFront returns a response



## Outputs

* `allowed_methods`

    HTTP methods forwarded to the origin

* `cached_cookies`

    Which cookies should be forwarded to the origin and included in the cache key. Pass `["*"]` to forward all cookies.

* `cached_headers`

    Which headers should be forwarded to the origin and included in the cache key. Pass `["*"]` to forward all headers.

* `cached_methods`

    HTTP methods that should be cached

* `cached_query_keys`

    Which URL query keys should be included in the cache key. Requires `forward_query = true`. Specify `["*"]` to include all query keys.

* `compress`

    Whether to compress origin responses using gzip.

* `forward_query`

    Whether to forward the URL query to the origin.

* `origin_id`

    Id of the origin that requests will be forwarded to.

* `origin_request_lambda`

    Lambda function to invoke before CloudFront sends a request to the origin

* `origin_response_lambda`

    Lambda function to invoke when CloudFront receives a response from origin

* `viewer_request_lambda`

    Lambda function to invoke when CloudFront receives a request

* `viewer_response_lambda`

    Lambda function to invoke before CloudFront returns a response

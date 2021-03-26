# cloudfront

AWS Cloudfront distribution

<!-- BEGIN_TF_DOCS -->

## Versions

| Provider  | Requirements |
| --------- | ------------ |
| terraform | `>= 0.12`    |
| `aws`     | `>= 2.40.0`  |

## Inputs

- `behaviors` (`map(object({
  path = string
  allowed_methods = list(string)

  cached_methods = list(string)
  cached_headers = list(string)
  cached_cookies = list(string)
  cached_query_keys = list(string)

  origin_id = string
  compress = bool
  forward_query = bool

  viewer_request_lambda = object({ arn = string, include_body = bool })
  origin_request_lambda = object({ arn = string, include_body = bool })
  origin_response_lambda = object({ arn = string })
  viewer_response_lambda = object({ arn = string })
  }))`, default: `{}`)

  Path specific caching behaviors

- `behaviors_order` (`list(string)`, default: `null`)

  Order in which behaviors should be resolved. Defaults to behaviors map order.

- `certificate_arn` (`string`, default: `null`)

  ACM certificate ARN to use instead of the default cloudfront certificate. Has to cover all specified `domains`.

- `create` (`bool`, default: `true`)

  Whether any resources should be created

- `default_behavior` (`object({
  allowed_methods = list(string)

  cached_methods = list(string)
  cached_headers = list(string)
  cached_cookies = list(string)
  cached_query_keys = list(string)

  origin_id = string
  compress = bool
  forward_query = bool

  viewer_request_lambda = object({ arn = string, include_body = bool })
  origin_request_lambda = object({ arn = string, include_body = bool })
  origin_response_lambda = object({ arn = string })
  viewer_response_lambda = object({ arn = string })
  })`, required)

  Default caching behavior

- `domains` (`list(string)`, default: `[]`)

  List of domains which will serve the application. If empty, will use the default cloudfront domain

- `error_responses` (`map(object({ response_code = number response_path = string }))`, default: `{}`)

  Custom error responses

- `http_origins` (`map(object({ domain = string path = string headers = map(string) port = number }))`, default: `{}`)

  HTTP origins proxied by this distribution

- `https_origins` (`map(object({ domain = string path = string headers = map(string) port = number }))`, default: `{}`)

  HTTPS origins proxied by this distribution

- `price_class` (`string`, default: `"PriceClass_100"`)

  CloudFront price class, which specifies where the distribution should be replicated, one of: PriceClass_100, PriceClass_200, PriceClass_All

- `s3_origins` (`map(object({ domain = string path = string headers = map(string) }))`, default: `{}`)

  AWS S3 buckets proxied by this distribution

- `tags` (`map(string)`, default: `{}`)

  Tags to add to resources

## Outputs

- `access_identity_arn`

  A pre-generated access identity ARN for use in S3 bucket policies.

- `access_identity_id`

  Access identity id for the distribution. For example: EDFDVBD632BHDS5.

- `arn`

  ARN of the distribution

- `domain`

  Domain of the distribution, eg. d604721fxaaqy9.cloudfront.net.

- `id`

  ID of the distribution

- `metrics`

  Cloudwatch monitoring metrics

- `url`

  URL of the distribution, eg. https://d604721fxaaqy9.cloudfront.net.

- `widgets`

  Cloudwatch dashboard widgets

- `zone_id`

  Route 53 zone ID that can be used to route an Alias Resource Record Set to.

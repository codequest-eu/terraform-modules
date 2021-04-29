# cloudfront/lambda/response_headers

Cloudfront origin response lambda which adds the specified headers to cloudfront responses.

Based on https://aws.amazon.com/blogs/networking-and-content-delivery/adding-http-security-headers-using-lambdaedge-and-amazon-cloudfront/

## Cloudfront invalidation

If you attach this lambda to the origin response hook keep in mind that cloudfront will only send requests to the origin (and call the lambda) if it doesn't already have the resource cached. This means that you won't see changes to response headers for cached paths. You will need to manually invalidate the cloudfront cache for changes to take effect.

Consult the [example](../../examples/response_headers) for how it could be done by terraform using a `null_resource` which uses AWS CLI to invalidate the cache whenever the lambda version changes.

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |

## Inputs

* `create` (`bool`, default: `true`)

    Should resources be created

* `global` (`map(string)`, default: `{}`)

    Headers to add to all responses

* `name` (`string`, required)

    Lambda name

* `rules` (`list(object({
    path         = string
    content_type = string
    headers      = map(string)
  }))`, default: `[]`)

    Rules for adding headers to some responses

* `tags` (`map(string)`, default: `{}`)

    Tags to add to resources that support them



## Outputs

* `arn`

    Lambda ARN

* `include_body`

    Whether cloudfront should include the viewer/origin request body

* `metrics`

    Cloudwatch monitoring metrics

* `widgets`

    Cloudwatch dashboard widgets

# cloudfront/lambda/response_headers

Cloudfront origin response lambda which adds the specified headers to cloudfront responses.

Based on https://aws.amazon.com/blogs/networking-and-content-delivery/adding-http-security-headers-using-lambdaedge-and-amazon-cloudfront/

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
  }))`, required)

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

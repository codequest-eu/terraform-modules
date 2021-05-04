# cloudfront/lambda

AWS Lambda middleware for AWS CloudFront

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `archive` | `>= 1.2.2` |
| `aws` | `>= 2.40.0` |

## Inputs

* `code` (`string`, required)

    Lambda code

* `create` (`bool`, default: `true`)

    Should resources be created

* `handler` (`string`, default: `"index.handler"`)

    Path to the function which will handle lambda calls

* `include_body` (`bool`, default: `false`)

    Whether the lambda requires viewer/origin request body

* `name` (`string`, required)

    Lambda name

* `runtime` (`string`, default: `"nodejs12.x"`)

    Lambda runtime

* `tags` (`map(string)`, default: `{}`)

    Tags to add to resources that support them

* `timeout` (`number`, default: `5`)

    The amount of time your Lambda Function has to run in seconds.

    Maximum of 5 for viewer events, 30 for origin events.
    https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/lambda-requirements-limits.html#lambda-requirements-see-limits




## Outputs

* `arn`

    Lambda ARN

* `include_body`

    Whether cloudfront should include the viewer/origin request body

* `metrics`

    Cloudwatch monitoring metrics

* `widgets`

    Cloudwatch dashboard widgets

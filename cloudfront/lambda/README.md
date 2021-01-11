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

* `name` (`string`, required)

    Lambda name

* `runtime` (`string`, default: `"nodejs12.x"`)

    Lambda runtime

* `tags` (`map(string)`, default: `{}`)

    Tags to add to resources that support them



## Outputs

* `arn`

    Lambda ARN

* `metrics`

    Cloudwatch monitoring metrics

* `widgets`

    Cloudwatch dashboard widgets

# cloudfront/lambda

AWS Lambda middleware for AWS CloudFront

<!-- BEGIN_TF_DOCS -->

## Versions

| Provider  | Requirements |
| --------- | ------------ |
| terraform | `>= 0.12`    |
| `archive` | `>= 1.2.2`   |
| `aws`     | `>= 2.40.0`  |

## Inputs

- `code` (`string`, required)

  Lambda code

- `create` (`bool`, default: `true`)

  Should resources be created

- `handler` (`string`, default: `"index.handler"`)

  Path to the function which will handle lambda calls

- `include_body` (`bool`, default: `false`)

  Whether the lambda requires viewer/origin request body

- `name` (`string`, required)

  Lambda name

- `runtime` (`string`, default: `"nodejs12.x"`)

  Lambda runtime

- `tags` (`map(string)`, default: `{}`)

  Tags to add to resources that support them

## Outputs

- `arn`

  Lambda ARN

- `include_body`

  Whether cloudfront should include the viewer/origin request body

- `metrics`

  Cloudwatch monitoring metrics

- `widgets`

  Cloudwatch dashboard widgets

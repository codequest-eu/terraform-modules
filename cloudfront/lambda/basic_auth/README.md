# cloudfront/lambda/basic_auth

Basic authentication middleware for AWS CloudFront

<!-- BEGIN_TF_DOCS -->

## Versions

| Provider  | Requirements |
| --------- | ------------ |
| terraform | `>= 0.12`    |

## Inputs

- `create` (`bool`, default: `true`)

  Should resources be created

- `credentials` (`string`, required)

  Basic auth credentials

- `name` (`string`, required)

  Lambda name

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

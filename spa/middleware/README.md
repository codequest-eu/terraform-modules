# spa/middleware

`spa` internal module which creates a single Lambda@Edge function to be attached to a CloudFront distribution as middleware.

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

- `name` (`string`, required)

  Lambda name

- `role_arn` (`string`, required)

  Role which should be assumed by the Lambda, created by middleware_common module

- `runtime` (`string`, default: `"nodejs10.x"`)

  Lambda runtime

- `tags` (`map(string)`, default: `{}`)

  Tags to add to resources that support them

## Outputs

- `arn`

  Lambda ARN

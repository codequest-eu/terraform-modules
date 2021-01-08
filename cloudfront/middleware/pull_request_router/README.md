# cloudfront/middleware/basic_auth

Pull request router for AWS CloudFront. Serves the right `index.html` based on a path prefix, by default `/PR-#/`. Useful for SPA preview environments.

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |

## Inputs

* `create` (`bool`, default: `true`)

    Should resources be created

* `name` (`string`, required)

    Lambda name

* `path_re` (`string`, default: `"^/(PR-\\d+)($|/)"`)

    Regular expression which extracts the base directory of a PR as it's first match group

* `tags` (`map(string)`, default: `{}`)

    Tags to add to resources that support them



## Outputs

* `arn`

    Lambda ARN

* `metrics`

    Cloudwatch monitoring metrics

* `widgets`

    Cloudwatch dashboard widgets
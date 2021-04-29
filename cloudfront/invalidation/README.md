# cloudfront/invalidation

AWS Cloudfront cache invalidation using `null_resource` and AWS CLI

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `null` | `>= 2.1.2` |

## Inputs

* `create` (`bool`, default: `true`)

    Whether any resources should be created

* `distribution_id` (`string`, required)

    Id of the cloudfront distribution to invalidate

* `paths` (`list(string)`, default: `["/*"]`)

    Paths that should be invalidated

* `triggers` (`map(string)`, default: `{}`)

    Map of values which when changed causes a cloudfront invalidation

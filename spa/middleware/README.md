# spa/middleware

`spa` internal module which creates a single Lambda@Edge function to be attached to a CloudFront distribution as middleware.

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `archive` | `>= 1.2.2` |
| `aws` | `>= 2.40.0` |

## Inputs

* `code` (`string`, required)

    

* `create` (`bool`, default: `true`)

    Should resources be created

* `handler` (`string`, default: `"index.handler"`)

    

* `name` (`string`, required)

    

* `role_arn` (`string`, required)

    

* `runtime` (`string`, default: `"nodejs10.x"`)

    

* `tags` (`map(string)`, required)

    



## Outputs

* `arn`

    

# cloudfront/origin/s3

S3 origin factory for the `cloudfront` module

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | (any version) |

## Inputs

* `bucket` (`string`, required)

    S3 bucket name.

* `create` (`bool`, default: `true`)

    Should resources be created

* `headers` (`map(string)`, default: `{}`)

    Additional headers to pass to S3

* `path` (`string`, default: `""`)

    Base S3 object path



## Outputs

* `domain`

    S3 bucket domain

* `headers`

    Additional headers to pass to S3

* `path`

    Base S3 object path

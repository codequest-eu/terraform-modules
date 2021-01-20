# cloudfront/origin/s3

S3 origin factory for the `cloudfront` module

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | (any version) |

## Inputs

* `bucket` (`string`, default: `null`)

    S3 bucket name. Either `bucket` or `bucket_regional_domain_name` is required. The bucket domain will be fetched using `data.aws_s3_bucket`.

* `bucket_regional_domain_name` (`string`, default: `null`)

    S3 bucket domain. Either `bucket` or `bucket_regional_domain_name` is required. Disables fetching the bucket using `data.aws_s3_bucket`.

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

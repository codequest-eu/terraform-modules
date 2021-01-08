# cloudfront/origin/s3/bucket_policy

S3 bucket policy to allow access from a cloudfront distribution

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | (any version) |
| `aws` | (any version) |

## Inputs

* `bucket_arn` (`string`, required)

    ARN of a bucket to give cloudfront access to

* `cloudfront_identity_arn` (`string`, required)

    ARN of a cloudfront identity which a distribution will use to access the bucket

* `create` (`bool`, default: `true`)

    Whether any resources should be created



## Outputs

* `json`

    Bucket policy JSON document

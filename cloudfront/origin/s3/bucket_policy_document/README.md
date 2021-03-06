# cloudfront/origin/s3/bucket_policy_document

S3 bucket policy to allow access from a cloudfront distribution

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |

## Inputs

* `access_identity_arns` (`list(string)`, required)

    ARNs of cloudfront access identities which will be used to access the bucket

* `bucket_arn` (`string`, required)

    ARN of a bucket to give cloudfront access to



## Outputs

* `json`

    Bucket policy JSON document

# AWS ACM Certificate

Creates an SSL certificate using AWS ACM, verifies domain ownership using Route53 and returns it's ARN, so it can be attached to AWS resources, eg. CloudFront.

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |

## Inputs

* `create` (`bool`, default: `true`)

    Should resources be created

* `create_validation_records` (`bool`, default: `true`)

    Whether to create DNS records for validation.

    When creating certificates for the same domain in different regions,
    ACM will request the same DNS records for validation, which will make
    terraform try to create the same records twice and fail.
    Use this variable to make sure only one of the modules creates
    the validation records.


* `domains` (`list(string)`, required)

    Certificate domains, have to be in one Route53 hosted zone.

* `hosted_zone_id` (`string`, required)

    Route53 hosted zone id for ACM domain ownership validation

* `tags` (`map(string)`, default: `{}`)

    Tags to set on resources that support them

* `validate` (`bool`, default: `true`)

    Whether to wait for certificate validation



## Outputs

* `arn`

    ACM certificate ARN

* `id`

    ACM certificate id

* `validated_arn`

    ACM certificate ARN, once it's validated

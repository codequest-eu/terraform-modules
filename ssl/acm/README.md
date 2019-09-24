# AWS ACM Certificate

Creates an SSL certificate using AWS ACM, verifies domain ownership using Route53 and returns it's ARN, so it can be attached to AWS resources, eg. CloudFront.

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.22.0` |

## Inputs

* `create` (`bool`, default: `true`)

    Should resources be created

* `domains` (`list(string)`, required)

    Certificate domains, have to be in one Route53 hosted zone.

* `hosted_zone_id` (`string`, required)

    Route53 hosted zone id for ACM domain ownership validation

* `tags` (`map(string)`, required)

    Tags to set on resources that support them



## Outputs

* `arn`

    ACM certificate ARN

* `id`

    ACM certificate id

* `validated_arn`

    ACM certificate ARN, once it's validated

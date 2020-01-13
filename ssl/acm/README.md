# AWS ACM Certificate

Creates an SSL certificate using AWS ACM, verifies domain ownership using Route53 and returns it's ARN, so it can be attached to AWS resources, eg. CloudFront.

## Known Issues

1. `terraform plan` fails after adding domains

   `aws_acm_certificate`'s `domain_validation_options` has somewhat non-deterministic behavior. When you add additional domains new validation DNS records need to be added for each new domain, however, at planning time `domain_validation_options` still has the current length, which causes errors like:

   ```
   Error: Invalid index

     on ../main.tf line 30, in resource "aws_route53_record" "validation":
     30:   name    = aws_acm_certificate.cert[0].domain_validation_options[count.index].resource_record_name
       |----------------
       | aws_acm_certificate.cert[0].domain_validation_options is list of object with 1 element
       | count.index is 1

   The given key does not identify an element in this collection value.
   ```

   To workaround the issue we've added a `validation_record_count` variable, with which you can temporarily override the number of validation records to create

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |

## Inputs

* `create` (`bool`, default: `true`)

    Should resources be created

* `domains` (`list(string)`, required)

    Certificate domains, have to be in one Route53 hosted zone.

* `hosted_zone_id` (`string`, required)

    Route53 hosted zone id for ACM domain ownership validation

* `tags` (`map(string)`, required)

    Tags to set on resources that support them

* `validation_record_count` (`number`, required)

    Override the number of validation records to work around aws_acm_certificate domain_validation_options non-deterministic behavior, eg. https://github.com/terraform-providers/terraform-provider-aws/issues/9840



## Outputs

* `arn`

    ACM certificate ARN

* `id`

    ACM certificate id

* `validated_arn`

    ACM certificate ARN, once it's validated

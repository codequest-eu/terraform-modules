# AWS ACM Certificate

Creates an SSL certificate using AWS ACM, verifies domain ownership using Route53 and returns it's ARN, so it can be attached to AWS resources, eg. CloudFront.

<!-- BEGIN_TF_DOCS -->

## Versions

| Provider  | Requirements |
| --------- | ------------ |
| terraform | `>= 0.12`    |
| `aws`     | `>= 3.0.0`   |

## Inputs

- `create` (`bool`, default: `true`)

  Should resources be created

- `create_validation_records` (`bool`, default: `true`)

  Whether to create DNS records for validation.

  When creating certificates for the same domain in different regions,
  ACM will request the same DNS records for validation, which will make
  terraform try to create the same records twice and fail.
  Use this variable to make sure only one of the modules creates
  the validation records.

- `domains` (`list(string)`, required)

  Certificate domains, have to be in one Route53 hosted zone.

- `hosted_zone_id` (`string`, default: `null`)

  Route53 hosted zone id for ACM domain ownership validation

- `tags` (`map(string)`, default: `{}`)

  Tags to set on resources that support them

- `validate` (`bool`, default: `true`)

  Whether to wait for certificate validation

- `validation_record_fqdns` (`list(string)`, default: `null`)

  When `create_validation_records` is `false` you can pass a list of `aws_route53_record.*.fqdn` to make sure validation checks don't start before the records are created.

## Outputs

- `arn`

  ACM certificate ARN

- `id`

  ACM certificate id

- `validated_arn`

  ACM certificate ARN, once it's validated

- `validation_records`

  DNS validation records, in cases where you want to manually create them

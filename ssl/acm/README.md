# AWS ACM Certificate

Creates an SSL certificate using AWS ACM, verifies domain ownership using Route53 and returns it's ARN, so it can be attached to AWS resources, eg. CloudFront.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 3.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate_validation.cert](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate_validation) | resource |
| [aws_route53_record.validation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_create_validation_records"></a> [create\_validation\_records](#input\_create\_validation\_records) | Whether to create DNS records for validation.<br><br>    When creating certificates for the same domain in different regions,<br>    ACM will request the same DNS records for validation, which will make<br>    terraform try to create the same records twice and fail.<br>    Use this variable to make sure only one of the modules creates<br>    the validation records. | `bool` | `true` | no |
| <a name="input_domains"></a> [domains](#input\_domains) | Certificate domains, have to be in one Route53 hosted zone. | `list(string)` | n/a | yes |
| <a name="input_hosted_zone_id"></a> [hosted\_zone\_id](#input\_hosted\_zone\_id) | Route53 hosted zone id for ACM domain ownership validation | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to set on resources that support them | `map(string)` | `{}` | no |
| <a name="input_validate"></a> [validate](#input\_validate) | Whether to wait for certificate validation | `bool` | `true` | no |
| <a name="input_validation_record_fqdns"></a> [validation\_record\_fqdns](#input\_validation\_record\_fqdns) | When `create_validation_records` is `false` you can pass a list of `aws_route53_record.*.fqdn` to make sure validation checks don't start before the records are created. | `list(string)` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ACM certificate ARN |
| <a name="output_id"></a> [id](#output\_id) | ACM certificate id |
| <a name="output_validated_arn"></a> [validated\_arn](#output\_validated\_arn) | ACM certificate ARN, once it's validated |
| <a name="output_validation_records"></a> [validation\_records](#output\_validation\_records) | DNS validation records, in cases where you want to manually create them |
<!-- END_TF_DOCS -->

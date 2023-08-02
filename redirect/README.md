# terraform-redirect

Common infrastructure for redirect proxy

## Overview

Module creates:

- AWS S3 bucket for redirection configuration
- AWS CloudFront distribution for SSL termination and geographical distribution

<!-- prettier-ignore-start -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.40.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.redirect](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_s3_bucket.redirect](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_object.empty](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object) | resource |
| [aws_s3_bucket_policy.redirect](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.redirect](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_iam_policy_document.public_get](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket"></a> [bucket](#input\_bucket) | Name for the S3 bucket which will do the redirect | `string` | n/a | yes |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | ACM certificate ARN to use instead of the default cloudfront certificate | `string` | n/a | yes |
| <a name="input_cloudfront_price_class"></a> [cloudfront\_price\_class](#input\_cloudfront\_price\_class) | CloudFront price class, which specifies where the distribution should be replicated, one of: PriceClass\_100, PriceClass\_200, PriceClass\_All | `string` | `"PriceClass_100"` | no |
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_domains"></a> [domains](#input\_domains) | List of domains which will be redirected. If empty, will use the default cloudfront domain | `list(string)` | n/a | yes |
| <a name="input_host"></a> [host](#input\_host) | Target host to which all the requests will be redirected (does not contain protocol) | `string` | n/a | yes |
| <a name="input_protocol"></a> [protocol](#input\_protocol) | Target protocol to which all the requests will be redirected (http or https) | `string` | `"https"` | no |
| <a name="input_redirect_status_code"></a> [redirect\_status\_code](#input\_redirect\_status\_code) | HTTP status code returned to the client | `number` | `302` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to each resource that supports them | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | ARN of the created redirection S3 bucket |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | Name of the created redirection S3 bucket |
| <a name="output_distribution_arn"></a> [distribution\_arn](#output\_distribution\_arn) | ARN of the created redirection CloudFront distribution |
| <a name="output_distribution_domain"></a> [distribution\_domain](#output\_distribution\_domain) | Domain of the created redirection CloudFront distribution, eg. d604721fxaaqy9.cloudfront.net. |
| <a name="output_distribution_id"></a> [distribution\_id](#output\_distribution\_id) | ID of the created redirection CloudFront distribution |
| <a name="output_distribution_url"></a> [distribution\_url](#output\_distribution\_url) | URL of the created redirection CloudFront distribution, eg. https://d604721fxaaqy9.cloudfront.net. |
| <a name="output_distribution_zone_id"></a> [distribution\_zone\_id](#output\_distribution\_zone\_id) | The CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to. |
<!-- END_TF_DOCS -->
<!-- prettier-ignore-end -->

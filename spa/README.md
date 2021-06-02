# terraform-single-page-app

> **DEPRECATED**
>
> Use the [`cloudfront`](../cloudfront) module instead

Common infrastructure for single page applications

## Overview

Module creates:

- AWS S3 bucket for storing assets
- AWS CloudFront distribution for serving the assets
- AWS IAM role for adding middleware Lambda@Edge functions
- Optional basic auth and pull request routing Lambdas

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.40.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | >= 2.1.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.40.0 |
| <a name="provider_template"></a> [template](#provider\_template) | >= 2.1.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_basic_auth"></a> [basic\_auth](#module\_basic\_auth) | ./middleware |  |
| <a name="module_middleware_common"></a> [middleware\_common](#module\_middleware\_common) | ./middleware_common |  |
| <a name="module_pull_request_router"></a> [pull\_request\_router](#module\_pull\_request\_router) | ./middleware |  |

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.assets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_identity.assets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_identity) | resource |
| [aws_iam_policy.ci](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_s3_bucket.assets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.assets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_iam_policy_document.assets_cdn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assets_cdn_website](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.ci](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [template_file.basic_auth](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |
| [template_file.pull_request_router](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_basic_auth_credentials"></a> [basic\_auth\_credentials](#input\_basic\_auth\_credentials) | Basic auth credentials in user:pass format | `string` | `null` | no |
| <a name="input_basic_auth_exclusions"></a> [basic\_auth\_exclusions](#input\_basic\_auth\_exclusions) | List of regular expressions describing paths excluded from the basic auth | `list(string)` | `[]` | no |
| <a name="input_bucket"></a> [bucket](#input\_bucket) | Kebab-cased bucket name override | `string` | `null` | no |
| <a name="input_certificate_arn"></a> [certificate\_arn](#input\_certificate\_arn) | ACM certificate ARN to use instead of the default cloudfront certificate | `string` | `null` | no |
| <a name="input_cloudfront_price_class"></a> [cloudfront\_price\_class](#input\_cloudfront\_price\_class) | CloudFront price class, which specifies where the distribution should be replicated, one of: PriceClass\_100, PriceClass\_200, PriceClass\_All | `string` | `"PriceClass_100"` | no |
| <a name="input_cloudfront_ssl_policy"></a> [cloudfront\_ssl\_policy](#input\_cloudfront\_ssl\_policy) | Cloudfront SSL policy, used only when `certificate_arn` is provided. See https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/secure-connections-supported-viewer-protocols-ciphers.html | `string` | `"TLSv1.2_2019"` | no |
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_domains"></a> [domains](#input\_domains) | List of domains which will serve the application. If empty, will use the default cloudfront domain | `list(string)` | `[]` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Kebab-cased name of the environment, eg. production, staging, development, preview. Will be included in resource names | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | Kebab-cased resource name prefix, defaults to project-environment | `string` | `null` | no |
| <a name="input_project"></a> [project](#input\_project) | Kebab-cased name of the project. Will be included in resource names | `string` | n/a | yes |
| <a name="input_pull_request_path_re"></a> [pull\_request\_path\_re](#input\_pull\_request\_path\_re) | Regular expression which extracts the base directory of a PR as it's first match group | `string` | `"^/(PR-\\d+)($|/)"` | no |
| <a name="input_pull_request_router"></a> [pull\_request\_router](#input\_pull\_request\_router) | Enables routing for pull request subdirectories | `bool` | `false` | no |
| <a name="input_static_cors_max_age_seconds"></a> [static\_cors\_max\_age\_seconds](#input\_static\_cors\_max\_age\_seconds) | How long can CORS OPTIONS request responses be cached | `number` | `3600` | no |
| <a name="input_static_path"></a> [static\_path](#input\_static\_path) | Base path for static assets | `string` | `"/static"` | no |
| <a name="input_static_website"></a> [static\_website](#input\_static\_website) | Use S3 static website hosting | `bool` | `false` | no |
| <a name="input_static_website_error"></a> [static\_website\_error](#input\_static\_website\_error) | S3 static website hosting error document path | `string` | `"404.html"` | no |
| <a name="input_static_website_index"></a> [static\_website\_index](#input\_static\_website\_index) | S3 static website index document | `string` | `"index.html"` | no |
| <a name="input_static_website_routing_rules"></a> [static\_website\_routing\_rules](#input\_static\_website\_routing\_rules) | S3 static website hosting routing rules | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to add to each resource that supports them | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arn"></a> [bucket\_arn](#output\_bucket\_arn) | ARN of the created assets S3 bucket |
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | Name of the created assets S3 bucket |
| <a name="output_ci_policy_arn"></a> [ci\_policy\_arn](#output\_ci\_policy\_arn) | ARN of the IAM policy which grants actions needed for CI/CD |
| <a name="output_distribution_arn"></a> [distribution\_arn](#output\_distribution\_arn) | ARN of the created assets CloudFront distribution |
| <a name="output_distribution_domain"></a> [distribution\_domain](#output\_distribution\_domain) | Domain of the created assets CloudFront distribution, eg. d604721fxaaqy9.cloudfront.net. |
| <a name="output_distribution_id"></a> [distribution\_id](#output\_distribution\_id) | ID of the created assets CloudFront distribution |
| <a name="output_distribution_url"></a> [distribution\_url](#output\_distribution\_url) | URL of the created assets CloudFront distribution, eg. https://d604721fxaaqy9.cloudfront.net. |
| <a name="output_distribution_zone_id"></a> [distribution\_zone\_id](#output\_distribution\_zone\_id) | The CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to. |
<!-- END_TF_DOCS -->

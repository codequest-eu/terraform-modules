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

## Versions

| Provider   | Requirements |
| ---------- | ------------ |
| terraform  | `>= 0.12`    |
| `aws`      | `>= 2.40.0`  |
| `template` | `>= 2.1.2`   |

## Inputs

- `basic_auth_credentials` (`string`, default: `null`)

  Basic auth credentials in user:pass format

- `bucket` (`string`, default: `null`)

  Kebab-cased bucket name override

- `certificate_arn` (`string`, default: `null`)

  ACM certificate ARN to use instead of the default cloudfront certificate

- `cloudfront_price_class` (`string`, default: `"PriceClass_100"`)

  CloudFront price class, which specifies where the distribution should be replicated, one of: PriceClass_100, PriceClass_200, PriceClass_All

- `create` (`bool`, default: `true`)

  Should resources be created

- `domains` (`list(string)`, default: `[]`)

  List of domains which will serve the application. If empty, will use the default cloudfront domain

- `environment` (`string`, required)

  Kebab-cased name of the environment, eg. production, staging, development, preview. Will be included in resource names

- `name_prefix` (`string`, default: `null`)

  Kebab-cased resource name prefix, defaults to project-environment

- `project` (`string`, required)

  Kebab-cased name of the project. Will be included in resource names

- `pull_request_path_re` (`string`, default: `"^/(PR-\\d+)($|/)"`)

  Regular expression which extracts the base directory of a PR as it's first match group

- `pull_request_router` (`bool`, default: `false`)

  Enables routing for pull request subdirectories

- `static_cors_max_age_seconds` (`number`, default: `3600`)

  How long can CORS OPTIONS request responses be cached

- `static_path` (`string`, default: `"/static"`)

  Base path for static assets

- `static_website` (`bool`, default: `false`)

  Use S3 static website hosting

- `static_website_error` (`string`, default: `"404.html"`)

  S3 static website hosting error document path

- `static_website_index` (`string`, default: `"index.html"`)

  S3 static website index document

- `static_website_routing_rules` (`string`, default: `null`)

  S3 static website hosting routing rules

- `tags` (`map(string)`, default: `{}`)

  Additional tags to add to each resource that supports them

## Outputs

- `bucket_arn`

  ARN of the created assets S3 bucket

- `bucket_name`

  Name of the created assets S3 bucket

- `ci_policy_arn`

  ARN of the IAM policy which grants actions needed for CI/CD

- `distribution_arn`

  ARN of the created assets CloudFront distribution

- `distribution_domain`

  Domain of the created assets CloudFront distribution, eg. d604721fxaaqy9.cloudfront.net.

- `distribution_id`

  ID of the created assets CloudFront distribution

- `distribution_url`

  URL of the created assets CloudFront distribution, eg. https://d604721fxaaqy9.cloudfront.net.

- `distribution_zone_id`

  The CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to.

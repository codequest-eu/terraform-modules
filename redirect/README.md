# terraform-redirect

Common infrastructure for redirect proxy

## Overview

Module creates:

- AWS S3 bucket for redirection configuration
- AWS CloudFront distribution for SSL termination and geographical distribution

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |
| `template` | `>= 2.1.2` |

## Inputs

* `bucket` (`string`, default: `null`)

    Kebab-cased bucket name override

* `certificate_arn` (`string`, required)

    ACM certificate ARN to use instead of the default cloudfront certificate

* `cloudfront_price_class` (`string`, default: `"PriceClass_100"`)

    CloudFront price class, which specifies where the distribution should be replicated, one of: PriceClass_100, PriceClass_200, PriceClass_All

* `create` (`bool`, default: `true`)

    Should resources be created

* `domains` (`list(string)`, required)

    List of domains which will be redirected. If empty, will use the default cloudfront domain

* `environment` (`string`, required)

    Kebab-cased name of the environment, eg. production, staging, development, preview. Will be included in resource names

* `host` (`string`, required)

    Target host to which all the requests will be redirected (does not contain protocol)

* `project` (`string`, required)

    Kebab-cased name of the project. Will be included in resource names

* `protocol` (`string`, required)

    Target protocol to which all the requests will be redirected (http or https)

* `redirect_status_code` (`number`, default: `302`)

    HTTP status code returned to the client

* `tags` (`map(string)`, default: `{}`)

    Additional tags to add to each resource that supports them



## Outputs

* `bucket_arn`

    ARN of the created redirection S3 bucket

* `bucket_name`

    Name of the created redirection S3 bucket

* `distribution_arn`

    ARN of the created redirection CloudFront distribution

* `distribution_domain`

    Domain of the created redirection CloudFront distribution, eg. d604721fxaaqy9.cloudfront.net.

* `distribution_id`

    ID of the created redirection CloudFront distribution

* `distribution_url`

    URL of the created redirection CloudFront distribution, eg. https://d604721fxaaqy9.cloudfront.net.

* `distribution_zone_id`

    The CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to.

# terraform-single-page-app

Common infrastructure for single page applications

## Overview

Module creates:

- AWS S3 bucket for storing assets
- AWS CloudFront distribution for serving the assets

## Variants

The [`master`](https://github.com/codequest-eu/terraform-single-page-app/tree/master) branch should be used for public production deployments, for development environments you might want to use:

- [`basic-auth`](https://github.com/codequest-eu/terraform-single-page-app/tree/basic-auth)

  Adds a AWS Lambda@Edge which protects the `index.html` using basic auth.
  Should be used for development and staging environments.

- [`pull-request-router`](https://github.com/codequest-eu/terraform-single-page-app/tree/pull-request-router)

  Adds a AWS Lambda@Edge which routes traffic to Pull Request specific `index.html`

- [`basic-auth-and-pull-request-router`](https://github.com/codequest-eu/terraform-single-page-app/tree/basic-auth-and-pull-request-router)

  Combines `basic-auth` and `pull-request-router`. Should be used for preview environments.

> **But Why!?**
> 
> [`aws_cloudfront_distribution`](https://www.terraform.io/docs/providers/aws/r/cloudfront_distribution.html) uses `lambda_function_association` blocks to add Lambda@Edge hooks, unfortunately `lambda_function_association` doesn't have any `enabled` flag, which means, as of terraform 0.11, it's not possible to add only some associations based on variables. 
> 
> This could be solved by:
> - terraform AWS provider by making `lambda_function_association` it's own resource, which we could toggle by setting `count`
> - terraform 0.12 which will make the configuration language a lot more powerful

## Inputs

| Name                            | Description                                                                                                                                 |  Type  |       Default        | Required |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- | :----: | :------------------: | :------: |
| basic\_auth\_credentials        | Basic auth credentials in user:pass format                                                                                                  | string |         n/a          |   yes    |
| bucket                          | Kebab-cased bucket name override                                                                                                            | string |         `""`         |    no    |
| certificate\_arn                | ACM certificate ARN to use instead of the default cloudfront certificate                                                                    | string |         `""`         |    no    |
| cloudfront\_price\_class        | CloudFront price class, which specifies where the distribution should be replicated, one of: PriceClass_100, PriceClass_200, PriceClass_All | string |  `"PriceClass_100"`  |    no    |
| domains                         | List of domains which will serve the application. If empty, will use the default cloudfront domain                                          |  list  |       `<list>`       |    no    |
| environment                     | Kebab-cased name of the environment, eg. production, staging, development, preview. Will be included in resource names                      | string |         n/a          |   yes    |
| project                         | Kebab-cased name of the project. Will be included in resource names                                                                         | string |         n/a          |   yes    |
| pull\_request\_path\_re         | Regular expression which extracts the base directory of a PR as it's first match group                                                      | string | `"^/(PR-\\d+)($|/)"` |    no    |
| static\_cors\_max\_age\_seconds | How long can CORS OPTIONS request responses be cached                                                                                       | string |       `"3600"`       |    no    |
| static\_path                    | Base path for static assets                                                                                                                 | string |     `"/static"`      |    no    |
| tags                            | Additional tags to add to each resource that supports them                                                                                  |  map   |       `<map>`        |    no    |

## Outputs

| Name                   | Description                                                                                   |
| ---------------------- | --------------------------------------------------------------------------------------------- |
| bucket\_arn            | ARN of the created assets S3 bucket                                                           |
| bucket\_name           | Name of the created assets S3 bucket                                                          |
| distribution\_arn      | ARN of the created assets CloudFront distribution                                             |
| distribution\_domain   | Domain of the created assets CloudFront distribution, eg. d604721fxaaqy9.cloudfront.net.      |
| distribution\_id       | ID of the created assets CloudFront distribution                                              |
| distribution\_url      | URL of the created assets CloudFront distribution, eg. https://d604721fxaaqy9.cloudfront.net. |
| distribution\_zone\_id | The CloudFront Route 53 zone ID that can be used to route an Alias Resource Record Set to.    |


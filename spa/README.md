# terraform-single-page-app

Common infrastructure for single page applications

## Overview

Module creates:

- AWS S3 bucket for storing assets
- AWS CloudFront distribution for serving the assets
- AWS IAM role for adding middleware Lambda@Edge functions
- Optional basic auth and pull request routing Lambdas

## Inputs

| Name                            | Description                                                                                                                                 |  Type  |       Default        | Required |
| ------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------- | :----: | :------------------: | :------: |
| basic\_auth\_credentials        | Basic auth credentials in user:pass format                                                                                                  | string |        `null`        |    no    |
| bucket                          | Kebab-cased bucket name override                                                                                                            | string |         `""`         |    no    |
| certificate\_arn                | ACM certificate ARN to use instead of the default cloudfront certificate                                                                    | string |         `""`         |    no    |
| cloudfront\_price\_class        | CloudFront price class, which specifies where the distribution should be replicated, one of: PriceClass_100, PriceClass_200, PriceClass_All | string |  `"PriceClass_100"`  |    no    |
| domains                         | List of domains which will serve the application. If empty, will use the default cloudfront domain                                          |  list  |       `<list>`       |    no    |
| environment                     | Kebab-cased name of the environment, eg. production, staging, development, preview. Will be included in resource names                      | string |         n/a          |   yes    |
| project                         | Kebab-cased name of the project. Will be included in resource names                                                                         | string |         n/a          |   yes    |
| pull\_request\_path\_re         | Regular expression which extracts the base directory of a PR as it's first match group                                                      | string | `"^/(PR-\\d+)($|/)"` |    no    |
| pull\_request\_router           | Enables routing for pull request subdirectories                                                                                             |  bool  |       `false`        |    no    |
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


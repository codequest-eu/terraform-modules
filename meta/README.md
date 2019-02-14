# Meta

Resources needed for terraform and it's CI/CD pipeline:

- AWS S3 bucket for persisting state
- AWS DynamoDB tables for state locking
- AWS IAM user for infrastructure repo CI/CD, which can basically do anything in the given AWS Account

## Inputs

| Name               | Description                                                                                                                                         |  Type  |        Default        | Required |
| ------------------ | --------------------------------------------------------------------------------------------------------------------------------------------------- | :----: | :-------------------: | :------: |
| account\_role\_arn | If meta is being created in a AWS Organizations Account, ARN of the IAM role that lets root account administrators manage member account resources. | string |         `""`          |    no    |
| meta\_state\_key   | Meta state file name                                                                                                                                | string |   `"meta.tfstate"`    |    no    |
| project            | Kebab-cased name of the project, will be used in resource names                                                                                     | string |          n/a          |   yes    |
| state\_key         | State file name                                                                                                                                     | string | `"terraform.tfstate"` |    no    |
| tags               | Additional tags to apply to resources which support them                                                                                            |  map   |        `<map>`        |    no    |

## Outputs

| Name                    | Description                               |
| ----------------------- | ----------------------------------------- |
| backend\_config         | Terraform backend config                  |
| ci\_access\_key\_id     | AWS access key for infrastructure CI user |
| ci\_secret\_access\_key | AWS secret key for infrastructure CI user |
| ci\_user\_arn           | Infrastructure CI AWS user ARN            |
| ci\_user\_name          | Infrastructure CI AWS user                |
| meta\_backend\_config   | Terraform meta backend config             |
| provider\_aws\_config   | Terraform AWS provider block              |


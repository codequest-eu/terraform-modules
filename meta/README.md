# Meta

Resources needed for terraform and it's CI/CD pipeline:

- AWS Account for a given project
- AWS S3 bucket for persisting state
- AWS DynamoDB tables for state locking
- AWS IAM user for infrastructure repo CI/CD, which can basically do anything in the given AWS Account

## Inputs

| Name           | Description                                                                                                                                                      |  Type  |              Default              | Required |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----: | :-------------------------------: | :------: |
| account\_email | E-mail address of the AWS account owner                                                                                                                          | string |                n/a                |   yes    |
| account\_role  | IAM role that is automatically created in the new account, which grants the organization's master account permission to access the newly created member account. | string | `"OrganizationAccountAccessRole"` |    no    |
| project        | Kebab-cased name of the project, will be used in resource names                                                                                                  | string |                n/a                |   yes    |
| region         | AWS region to create resources in, eg. eu-west-1                                                                                                                 | string |                n/a                |   yes    |
| tags           | Additional tags to apply to resources which support them                                                                                                         |  map   |              `<map>`              |    no    |

## Outputs

| Name                    | Description                                                               |
| ----------------------- | ------------------------------------------------------------------------- |
| account\_arn            | AWS project account ARN                                                   |
| account\_id             | AWS project account id                                                    |
| account\_role\_arn      | IAM role ARN for root account administrators to manage the member account |
| backend\_config         | Terraform backend config                                                  |
| ci\_access\_key\_id     | AWS access key for infrastructure CI user                                 |
| ci\_secret\_access\_key | AWS secret key for infrastructure CI user                                 |
| ci\_user\_arn           | Infrastructure CI AWS user ARN                                            |
| ci\_user\_name          | Infrastructure CI AWS user                                                |
| meta\_backend\_config   | Terraform meta backend config                                             |
| provider\_aws\_config   | Terraform AWS provider block                                              |


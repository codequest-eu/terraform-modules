# AWS Orgniazation Account

Creates a sub-account for a given project's, environment's resources.

## Inputs

| Name  | Description                                                                                                                                                      |  Type  |              Default              | Required |
| ----- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- | :----: | :-------------------------------: | :------: |
| email | E-mail address of the AWS account owner                                                                                                                          | string |                n/a                |   yes    |
| name  | AWS account name, usually the name of the project                                                                                                                | string |                n/a                |   yes    |
| role  | IAM role that is automatically created in the new account, which grants the organization's master account permission to access the newly created member account. | string | `"OrganizationAccountAccessRole"` |    no    |

## Outputs

| Name             | Description                                                               |
| ---------------- | ------------------------------------------------------------------------- |
| arn              | AWS project account ARN                                                   |
| id               | AWS project account id                                                    |
| provider\_config | Terraform AWS provider block                                              |
| role\_arn        | IAM role ARN for root account administrators to manage the member account |


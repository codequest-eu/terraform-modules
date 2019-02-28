# Meta

Resources needed for terraform and it's CI/CD pipeline:

- AWS S3 bucket for persisting state
- AWS DynamoDB tables for state locking
- AWS IAM user for infrastructure repo CI/CD, which can basically do anything in the given AWS Account

## Terraform backend setup

You need to kick off the meta infrastructure without a remote backend, since it's infrastructure is created by this module.
Here's a step by step tutorial how such a kick off looks like:

1. Add a meta module 
2. Run `terraform apply` to create the necessary infrastructure
3. Add backend configuration to your code by pasting the output of:

    ```sh
    terraform output -module NAME_OF_META_MODULE meta_backend_config
    ```

3. Run `terraform init` to transfer the local state to S3
4. Remove local `terraform.tfstate`

Actual project infrastructure state is separate from the meta state, to configure the backend for project infrastructure just paste the output of 

```sh
terraform output -module NAME_OF_META_MODULE backend_config
```

## Inputs

| Name               | Description                                                                                                                                          |  Type  |        Default        | Required |
| ------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------- | :----: | :-------------------: | :------: |
| account\_role\_arn | If meta is being created in an AWS Organizations Account, ARN of the IAM role that lets root account administrators manage member account resources. | string |         `""`          |    no    |
| meta\_state\_key   | Meta state file name                                                                                                                                 | string |   `"meta.tfstate"`    |    no    |
| project            | Kebab-cased name of the project, will be used in resource names                                                                                      | string |          n/a          |   yes    |
| state\_bucket      | Kebab-cased state bucket name override                                                                                                               | string |         `""`          |    no    |
| state\_key         | State file name                                                                                                                                      | string | `"terraform.tfstate"` |    no    |
| tags               | Additional tags to apply to resources which support them                                                                                             |  map   |        `<map>`        |    no    |

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


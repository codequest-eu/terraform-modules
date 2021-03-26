# terraform/backend/s3

Creates resources needed to use a terraform S3 backend with locking

<!-- BEGIN_TF_DOCS -->

## Versions

| Provider  | Requirements |
| --------- | ------------ |
| terraform | `>= 0.12`    |
| `aws`     | `>= 2.40.0`  |

## Inputs

- `bucket_force_destroy` (`bool`, default: `false`)

  Allow destroying the state bucket even if it's not empty

- `bucket_name` (`string`, required)

  State bucket name

- `create` (`bool`, default: `true`)

  Whether any resources should be created

- `lock_table_name` (`string`, default: `null`)

  DynamoDB lock table name, defaults to `{bucket}-lock`

- `tags` (`map(string)`, default: `{}`)

  Tags to add to resources

## Outputs

- `backend_config`

  Terraform backend config map

- `backend_config_template`

  Terraform backend block template

- `backend_type`

  Terraform backend type

- `bucket_arn`

  State bucket ARN

- `bucket_name`

  State bucket name

- `lock_table_arn`

  State lock table ARN

- `lock_table_name`

  State lock table name

- `remote_state_template`

  terraform_remote_state block template

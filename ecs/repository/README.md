# ECS Repository

Creates an ECR repository and a policy for CI which allows push/pull access.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.40.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.repo](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_iam_policy.ci](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy_document.ci](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_image_name"></a> [image\_name](#input\_image\_name) | Container image name | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Kebab-cased project name | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources that support them | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | ECR repository ARN |
| <a name="output_ci_policy_arn"></a> [ci\_policy\_arn](#output\_ci\_policy\_arn) | IAM policy ARN for CI |
| <a name="output_ci_policy_name"></a> [ci\_policy\_name](#output\_ci\_policy\_name) | IAM policy name for CI |
| <a name="output_name"></a> [name](#output\_name) | ECR repository name |
| <a name="output_registry_id"></a> [registry\_id](#output\_registry\_id) | ECR registry id where the repository was created |
| <a name="output_url"></a> [url](#output\_url) | ECR repository URL |
<!-- END_TF_DOCS -->

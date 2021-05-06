# ECS Access

Creates IAM resources needed to run host instances and services in the ECS cluster.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
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
| [aws_iam_instance_profile.host](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.host_metrics](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.host](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.web_service](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.host_cloudwatch_agent](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.host_ec2_for_ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.host_ecs_for_ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.host_metrics](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.web_service_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_policy_document.assume_ec2_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.assume_ecs_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.host_metrics](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Kebab-cased environment name, eg. development, staging, production. | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | Kebab-cased project name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_host_profile_arn"></a> [host\_profile\_arn](#output\_host\_profile\_arn) | ECS host instance profile ARN |
| <a name="output_host_profile_id"></a> [host\_profile\_id](#output\_host\_profile\_id) | ECS host instance profile ID |
| <a name="output_host_profile_name"></a> [host\_profile\_name](#output\_host\_profile\_name) | ECS host instance profile name |
| <a name="output_host_role_arn"></a> [host\_role\_arn](#output\_host\_role\_arn) | ECS host role ARN |
| <a name="output_host_role_name"></a> [host\_role\_name](#output\_host\_role\_name) | ECS host role name |
| <a name="output_web_service_role_arn"></a> [web\_service\_role\_arn](#output\_web\_service\_role\_arn) | ECS web service task role ARN |
| <a name="output_web_service_role_name"></a> [web\_service\_role\_name](#output\_web\_service\_role\_name) | ECS web service task role name |
<!-- END_TF_DOCS -->

# ecs/run_task

Runs a task in an ECS cluster using a `null_resource`.

Useful for running one-off tasks, like database migrations, during a deployment.

Since it uses `null_resource` with a `local-exec` provisioner it requires:

- bash
- AWS CLI v2
- jq 1.6

<!-- prettier-ignore-start -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 2.1.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0.0 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 2.1.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [null_resource.run](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cluster_arn"></a> [cluster\_arn](#input\_cluster\_arn) | ECS cluster ARN to run the task in | `string` | n/a | yes |
| <a name="input_task_definition_arn"></a> [task\_definition\_arn](#input\_task\_definition\_arn) | ARN of the task definition to run | `string` | n/a | yes |
| <a name="input_task_overrides"></a> [task\_overrides](#input\_task\_overrides) | Task overrides to apply, e.g. to set the right command, JSON-encoded | `string` | `"{}"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
<!-- prettier-ignore-end -->

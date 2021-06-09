# ecs/host_group

Creates an auto-scaling group of EC2 instances which will join the given ECS cluster.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <0.13 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.40.0 |
| <a name="requirement_template"></a> [template](#requirement\_template) | >= 2.1.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.40.0 |
| <a name="provider_template"></a> [template](#provider\_template) | >= 2.1.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudwatch_consts"></a> [cloudwatch\_consts](#module\_cloudwatch\_consts) | ./../../cloudwatch/consts | n/a |
| <a name="module_metric_cpu_credit_usage"></a> [metric\_cpu\_credit\_usage](#module\_metric\_cpu\_credit\_usage) | ./../../cloudwatch/metric | n/a |
| <a name="module_metric_memory_utilization"></a> [metric\_memory\_utilization](#module\_metric\_memory\_utilization) | ./../../cloudwatch/metric | n/a |
| <a name="module_metric_swap_utilization"></a> [metric\_swap\_utilization](#module\_metric\_swap\_utilization) | ./../../cloudwatch/metric | n/a |
| <a name="module_metrics_cpu_credit_balance"></a> [metrics\_cpu\_credit\_balance](#module\_metrics\_cpu\_credit\_balance) | ./../../cloudwatch/metric/many | n/a |
| <a name="module_metrics_cpu_utilization"></a> [metrics\_cpu\_utilization](#module\_metrics\_cpu\_utilization) | ./../../cloudwatch/metric/many | n/a |
| <a name="module_metrics_instance_count"></a> [metrics\_instance\_count](#module\_metrics\_instance\_count) | ./../../cloudwatch/metric/many | n/a |
| <a name="module_metrics_io"></a> [metrics\_io](#module\_metrics\_io) | ./../../cloudwatch/metric/many | n/a |
| <a name="module_metrics_memory_utilization"></a> [metrics\_memory\_utilization](#module\_metrics\_memory\_utilization) | ./../../cloudwatch/metric/many | n/a |
| <a name="module_metrics_root_fs_free"></a> [metrics\_root\_fs\_free](#module\_metrics\_root\_fs\_free) | ./../../cloudwatch/metric/many | n/a |
| <a name="module_metrics_root_fs_utilization"></a> [metrics\_root\_fs\_utilization](#module\_metrics\_root\_fs\_utilization) | ./../../cloudwatch/metric/many | n/a |
| <a name="module_metrics_swap_utilization"></a> [metrics\_swap\_utilization](#module\_metrics\_swap\_utilization) | ./../../cloudwatch/metric/many | n/a |
| <a name="module_widget_cpu_credit_balance"></a> [widget\_cpu\_credit\_balance](#module\_widget\_cpu\_credit\_balance) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_cpu_credit_usage"></a> [widget\_cpu\_credit\_usage](#module\_widget\_cpu\_credit\_usage) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_cpu_utilization"></a> [widget\_cpu\_utilization](#module\_widget\_cpu\_utilization) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_fs_io_bytes"></a> [widget\_fs\_io\_bytes](#module\_widget\_fs\_io\_bytes) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_fs_io_ops"></a> [widget\_fs\_io\_ops](#module\_widget\_fs\_io\_ops) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_instance_scaling"></a> [widget\_instance\_scaling](#module\_widget\_instance\_scaling) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_instance_states"></a> [widget\_instance\_states](#module\_widget\_instance\_states) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_memory_utilization"></a> [widget\_memory\_utilization](#module\_widget\_memory\_utilization) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_network_bytes"></a> [widget\_network\_bytes](#module\_widget\_network\_bytes) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_network_packets"></a> [widget\_network\_packets](#module\_widget\_network\_packets) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_root_fs_free"></a> [widget\_root\_fs\_free](#module\_widget\_root\_fs\_free) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_root_fs_utilization"></a> [widget\_root\_fs\_utilization](#module\_widget\_root\_fs\_utilization) | ./../../cloudwatch/metric_widget | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_group.hosts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_launch_configuration.hosts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_configuration) | resource |
| [aws_launch_template.hosts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_ami.ecs_amazon_linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [template_file.user_data](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami_name"></a> [ami\_name](#input\_ami\_name) | ECS-optimized Amazon Linux AMI name to use | `string` | `"amzn2-ami-ecs-hvm-2.0.20200319-x86_64-ebs"` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | Name of the ECS cluster to attach to | `string` | n/a | yes |
| <a name="input_cpu_credits"></a> [cpu\_credits](#input\_cpu\_credits) | The credit option for CPU usage. Can be 'standard' or 'unlimited'. | `string` | `null` | no |
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_detailed_monitoring"></a> [detailed\_monitoring](#input\_detailed\_monitoring) | Whether to enable detailed monitoring on EC2 instances | `bool` | `true` | no |
| <a name="input_ecs_agent_config"></a> [ecs\_agent\_config](#input\_ecs\_agent\_config) | ECS agent configuration to append to the default one | `string` | `""` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Kebab-cased environment name, eg. development, staging, production. | `string` | n/a | yes |
| <a name="input_instance_profile"></a> [instance\_profile](#input\_instance\_profile) | Name of the instance profile created by the ecs/worker\_role module | `string` | n/a | yes |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | EC2 instance type | `string` | n/a | yes |
| <a name="input_max_size"></a> [max\_size](#input\_max\_size) | The maximum size of the auto scale group, defaults to size | `number` | `null` | no |
| <a name="input_min_size"></a> [min\_size](#input\_min\_size) | The minimum size of the auto scale group, defaults to size | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | Kebab-cased host name to distinguish different types of hosts in the same environment | `string` | `"hosts"` | no |
| <a name="input_project"></a> [project](#input\_project) | Kebab-cased project name | `string` | n/a | yes |
| <a name="input_security_group_id"></a> [security\_group\_id](#input\_security\_group\_id) | ID of the security group created by ecs/network module for host instances | `string` | n/a | yes |
| <a name="input_size"></a> [size](#input\_size) | The number of Amazon EC2 instances that should be running in the group | `number` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Ids of subnets hosts should be launched in, private subnets created by the ecs/network module | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources that support them | `map(string)` | `{}` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Bash script to append to the default user data script | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Autoscaling group ARN |
| <a name="output_id"></a> [id](#output\_id) | Autoscaling group id |
| <a name="output_metrics"></a> [metrics](#output\_metrics) | Cloudwatch metrics, see [metrics.tf](./metrics.tf) |
| <a name="output_widgets"></a> [widgets](#output\_widgets) | Cloudwatch dashboard widgets, see [widgets.tf](./widgets.tf) |
<!-- END_TF_DOCS -->

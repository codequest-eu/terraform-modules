# ECS

Creates an ECS cluster along with the necessary IAM resources ([`ecs/access`](./access)) and a standard networking setup ([`ecs/network`](./network)).

Based on [AWS reference architecture](https://github.com/aws-samples/ecs-refarch-cloudformation) and [segmentio/stack](https://github.com/segmentio/stack)

## Modules

- [`ecs/access`](./access)

  Creates IAM resources needed for the cluster. Instantiated by the `ecs` module.

- [`ecs/host_group`](./host_group)

  Creates an autoscaling group of EC2 instances for running tasks within the cluster

- [`ecs/network`](./network)

  Creates the networking stack for the cluster. Instantiated by the `ecs` module.

- [`ecs/repository`](./repository)

  Creates an ECR container image repository.

- [`ecs/services/web`](./services/web)

  Creates an ECS service exposed to the web via an Application Load Balancer.

- [`ecs/services/worker`](./services/worker)

  Creates an internal ECS service for running tasks from some queue.

- [`ecs/task`](./task)

  Creates an ECS task definition

<!-- prettier-ignore-start -->
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

| Name | Source | Version |
|------|--------|---------|
| <a name="module_access"></a> [access](#module\_access) | ./access | n/a |
| <a name="module_cloudwatch_consts"></a> [cloudwatch\_consts](#module\_cloudwatch\_consts) | ./../cloudwatch/consts | n/a |
| <a name="module_metrics_count"></a> [metrics\_count](#module\_metrics\_count) | ./../cloudwatch/metric/many | n/a |
| <a name="module_metrics_cpu"></a> [metrics\_cpu](#module\_metrics\_cpu) | ./../cloudwatch/metric/many | n/a |
| <a name="module_metrics_memory"></a> [metrics\_memory](#module\_metrics\_memory) | ./../cloudwatch/metric/many | n/a |
| <a name="module_network"></a> [network](#module\_network) | ./network | n/a |
| <a name="module_widget_cpu_utilization"></a> [widget\_cpu\_utilization](#module\_widget\_cpu\_utilization) | ./../cloudwatch/metric_widget | n/a |
| <a name="module_widget_instances"></a> [widget\_instances](#module\_widget\_instances) | ./../cloudwatch/metric_widget | n/a |
| <a name="module_widget_memory_utilization"></a> [widget\_memory\_utilization](#module\_widget\_memory\_utilization) | ./../cloudwatch/metric_widget | n/a |
| <a name="module_widget_services"></a> [widget\_services](#module\_widget\_services) | ./../cloudwatch/metric_widget | n/a |
| <a name="module_widget_tasks"></a> [widget\_tasks](#module\_widget\_tasks) | ./../cloudwatch/metric_widget | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_ecs_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecs_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones_count"></a> [availability\_zones\_count](#input\_availability\_zones\_count) | Number of availability zones the network should span | `number` | `2` | no |
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_enable_container_insights"></a> [enable\_container\_insights](#input\_enable\_container\_insights) | Enable/disable container insights for the ECS cluster | `bool` | `false` | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | Enable/disable DNS hostnames in the VPC | `bool` | `false` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | Enable/disable DNS support in the VPC | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Kebab-cased environment name, eg. development, staging, production. | `string` | n/a | yes |
| <a name="input_lb_ssl_policy"></a> [lb\_ssl\_policy](#input\_lb\_ssl\_policy) | SSL policy to set on the HTTPS ALB listener, see https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-https-listener.html#describe-ssl-policies | `string` | `"ELBSecurityPolicy-TLS-1-2-2017-01"` | no |
| <a name="input_nat_instance"></a> [nat\_instance](#input\_nat\_instance) | Use NAT instances instead of NAT gateways. | `bool` | `false` | no |
| <a name="input_nat_instance_ami_name"></a> [nat\_instance\_ami\_name](#input\_nat\_instance\_ami\_name) | Name of the EC2 AMI used by NAT instances | `string` | `"amzn-ami-vpc-nat-2018.03.0.20200318.1-x86_64-ebs"` | no |
| <a name="input_nat_instance_type"></a> [nat\_instance\_type](#input\_nat\_instance\_type) | EC2 instance type to use to create a NAT instance. | `string` | `"t3.nano"` | no |
| <a name="input_project"></a> [project](#input\_project) | Kebab-cased project name | `string` | n/a | yes |
| <a name="input_project_index"></a> [project\_index](#input\_project\_index) | Unique project number in 0-255 range which will be used to build the VPC CIDR block: 10.{project\_index}.0.0/16 | `number` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources that support them | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Cluster ARN |
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | The availability zones in which corresponding public and private subnets were created |
| <a name="output_host_profile_arn"></a> [host\_profile\_arn](#output\_host\_profile\_arn) | ECS host instance profile ARN |
| <a name="output_host_profile_id"></a> [host\_profile\_id](#output\_host\_profile\_id) | ECS host instance profile ID |
| <a name="output_host_profile_name"></a> [host\_profile\_name](#output\_host\_profile\_name) | ECS host instance profile name |
| <a name="output_host_role_arn"></a> [host\_role\_arn](#output\_host\_role\_arn) | ECS host role ARN |
| <a name="output_host_role_name"></a> [host\_role\_name](#output\_host\_role\_name) | ECS host role name |
| <a name="output_hosts_security_group_arn"></a> [hosts\_security\_group\_arn](#output\_hosts\_security\_group\_arn) | The ARN of the Security Group which should be used by host instances |
| <a name="output_hosts_security_group_id"></a> [hosts\_security\_group\_id](#output\_hosts\_security\_group\_id) | The ID of the Security Group which should be used by host instances |
| <a name="output_http_listener_arn"></a> [http\_listener\_arn](#output\_http\_listener\_arn) | The ARN of the ALB's HTTP Listener |
| <a name="output_https_listener_arn"></a> [https\_listener\_arn](#output\_https\_listener\_arn) | The ARN of the ALB's HTTPS Listener |
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | The ID of the Internet Gateway |
| <a name="output_lb_metrics"></a> [lb\_metrics](#output\_lb\_metrics) | Load balancer related Cloudwatch metrics, see [network/metrics.tf](./network/metrics.tf) |
| <a name="output_lb_widgets"></a> [lb\_widgets](#output\_lb\_widgets) | Load balancer related Cloudwatch dashboard widgets, see [network/widgets.tf](./network/widgets.tf) |
| <a name="output_load_balancer_arn"></a> [load\_balancer\_arn](#output\_load\_balancer\_arn) | The ARN of the Application Load Balancer |
| <a name="output_load_balancer_domain"></a> [load\_balancer\_domain](#output\_load\_balancer\_domain) | The domain name of the Application Load Balancer |
| <a name="output_load_balancer_id"></a> [load\_balancer\_id](#output\_load\_balancer\_id) | The ID of the Application Load Balancer |
| <a name="output_load_balancer_security_group_arn"></a> [load\_balancer\_security\_group\_arn](#output\_load\_balancer\_security\_group\_arn) | The ARN of the Application Load Balancer's Security Group |
| <a name="output_load_balancer_security_group_id"></a> [load\_balancer\_security\_group\_id](#output\_load\_balancer\_security\_group\_id) | The ID of the Application Load Balancer's Security Group |
| <a name="output_load_balancer_zone_id"></a> [load\_balancer\_zone\_id](#output\_load\_balancer\_zone\_id) | The canonical hosted zone ID of the Application Load Balancer (to be used in a Route 53 Alias record) |
| <a name="output_metrics"></a> [metrics](#output\_metrics) | ECS cluster Cloudwatch metrics, see [metrics.tf](./metrics.tf) for details |
| <a name="output_name"></a> [name](#output\_name) | Cluster name |
| <a name="output_nat_gateway_metrics"></a> [nat\_gateway\_metrics](#output\_nat\_gateway\_metrics) | NAT gateway related Cloudwatch metrics, see [network/metrics.tf](./network/metrics.tf) |
| <a name="output_nat_gateway_widgets"></a> [nat\_gateway\_widgets](#output\_nat\_gateway\_widgets) | NAT gateway related Cloudwatch dashboard widgets, see [network/widgets.tf](./network/widgets.tf) |
| <a name="output_nat_instance_metrics"></a> [nat\_instance\_metrics](#output\_nat\_instance\_metrics) | NAT instance related Cloudwatch metrics, see [network/metrics.tf](./network/metrics.tf) |
| <a name="output_nat_instance_widgets"></a> [nat\_instance\_widgets](#output\_nat\_instance\_widgets) | NAT instance related Cloudwatch dashboard widgets, see [network/widgets.tf](./network/widgets.tf) |
| <a name="output_private_blocks"></a> [private\_blocks](#output\_private\_blocks) | The CIDR blocks of private subnets |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | The IDs of private subnets |
| <a name="output_public_blocks"></a> [public\_blocks](#output\_public\_blocks) | The CIDR blocks of public subnets |
| <a name="output_public_gateway_ips"></a> [public\_gateway\_ips](#output\_public\_gateway\_ips) | The public IP addresses of nat gateways used for outbound traffic |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | The IDs of public subnets |
| <a name="output_vpc_block"></a> [vpc\_block](#output\_vpc\_block) | The CIDR block of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a name="output_web_service_role_arn"></a> [web\_service\_role\_arn](#output\_web\_service\_role\_arn) | ECS web service task role ARN |
| <a name="output_web_service_role_name"></a> [web\_service\_role\_name](#output\_web\_service\_role\_name) | ECS web service task role name |
| <a name="output_widgets"></a> [widgets](#output\_widgets) | ECS cluster Cloudwatch dashboard widgets, see [widgets.tf](./widgets.tf) for details |
<!-- END_TF_DOCS -->
<!-- prettier-ignore-end -->

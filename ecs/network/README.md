# ECS network

Creates networking resources needed for a standard ECS cluster setup:

1. A single VPC with Internet Gateway
2. Public and private subnet in each availability zone
3. NAT Gateway in each public subnet for outbound traffic
4. Application Load Balancer for inbound traffic with HTTP and HTTPS listeners

# To do

- [ ] S3 bucket for ALB Logs

<!-- prettier-ignore-start -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12, <2.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.0.0 |
| <a name="requirement_cloudinit"></a> [cloudinit](#requirement\_cloudinit) | >= 2.3.3 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 2.1.2 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | >= 3.2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.0.0 |
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | >= 2.3.3 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 2.1.2 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | >= 3.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudwatch_consts"></a> [cloudwatch\_consts](#module\_cloudwatch\_consts) | ./../../cloudwatch/consts | n/a |
| <a name="module_metric_consumed_lcus"></a> [metric\_consumed\_lcus](#module\_metric\_consumed\_lcus) | ./../../cloudwatch/metric | n/a |
| <a name="module_metric_lb_active_connections"></a> [metric\_lb\_active\_connections](#module\_metric\_lb\_active\_connections) | ./../../cloudwatch/metric | n/a |
| <a name="module_metric_lb_new_connections"></a> [metric\_lb\_new\_connections](#module\_metric\_lb\_new\_connections) | ./../../cloudwatch/metric | n/a |
| <a name="module_metric_lb_responses"></a> [metric\_lb\_responses](#module\_metric\_lb\_responses) | ./../../cloudwatch/metric_expression | n/a |
| <a name="module_metric_lb_traffic"></a> [metric\_lb\_traffic](#module\_metric\_lb\_traffic) | ./../../cloudwatch/metric | n/a |
| <a name="module_metric_nat_instance_average_cpu_utilization"></a> [metric\_nat\_instance\_average\_cpu\_utilization](#module\_metric\_nat\_instance\_average\_cpu\_utilization) | ./../../cloudwatch/metric_expression | n/a |
| <a name="module_metric_nat_instance_cpu_credit_usage"></a> [metric\_nat\_instance\_cpu\_credit\_usage](#module\_metric\_nat\_instance\_cpu\_credit\_usage) | ./../../cloudwatch/metric_expression | n/a |
| <a name="module_metric_nat_instance_max_cpu_utilization"></a> [metric\_nat\_instance\_max\_cpu\_utilization](#module\_metric\_nat\_instance\_max\_cpu\_utilization) | ./../../cloudwatch/metric_expression | n/a |
| <a name="module_metric_nat_instance_min_cpu_utilization"></a> [metric\_nat\_instance\_min\_cpu\_utilization](#module\_metric\_nat\_instance\_min\_cpu\_utilization) | ./../../cloudwatch/metric_expression | n/a |
| <a name="module_metric_requests"></a> [metric\_requests](#module\_metric\_requests) | ./../../cloudwatch/metric_expression | n/a |
| <a name="module_metrics_nat_gateway_bytes"></a> [metrics\_nat\_gateway\_bytes](#module\_metrics\_nat\_gateway\_bytes) | ./../../cloudwatch/metric/many | n/a |
| <a name="module_metrics_nat_gateway_connections"></a> [metrics\_nat\_gateway\_connections](#module\_metrics\_nat\_gateway\_connections) | ./../../cloudwatch/metric/many | n/a |
| <a name="module_metrics_nat_gateway_packets"></a> [metrics\_nat\_gateway\_packets](#module\_metrics\_nat\_gateway\_packets) | ./../../cloudwatch/metric/many | n/a |
| <a name="module_metrics_nat_gateway_packets_dropped"></a> [metrics\_nat\_gateway\_packets\_dropped](#module\_metrics\_nat\_gateway\_packets\_dropped) | ./../../cloudwatch/metric | n/a |
| <a name="module_metrics_nat_instance_cpu_credit_balance"></a> [metrics\_nat\_instance\_cpu\_credit\_balance](#module\_metrics\_nat\_instance\_cpu\_credit\_balance) | ./../../cloudwatch/metric_expression/many | n/a |
| <a name="module_metrics_nat_instance_io"></a> [metrics\_nat\_instance\_io](#module\_metrics\_nat\_instance\_io) | ./../../cloudwatch/metric_expression/many | n/a |
| <a name="module_metrics_response_count"></a> [metrics\_response\_count](#module\_metrics\_response\_count) | ./../../cloudwatch/metric/many | n/a |
| <a name="module_metrics_response_percentage"></a> [metrics\_response\_percentage](#module\_metrics\_response\_percentage) | ./../../cloudwatch/metric_expression/many | n/a |
| <a name="module_metrics_target_response_time"></a> [metrics\_target\_response\_time](#module\_metrics\_target\_response\_time) | ./../../cloudwatch/metric/many | n/a |
| <a name="module_widget_lb_connections"></a> [widget\_lb\_connections](#module\_widget\_lb\_connections) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_lb_lcus"></a> [widget\_lb\_lcus](#module\_widget\_lb\_lcus) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_lb_traffic"></a> [widget\_lb\_traffic](#module\_widget\_lb\_traffic) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_nat_gateway_active_connections"></a> [widget\_nat\_gateway\_active\_connections](#module\_widget\_nat\_gateway\_active\_connections) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_nat_gateway_connection_attempts"></a> [widget\_nat\_gateway\_connection\_attempts](#module\_widget\_nat\_gateway\_connection\_attempts) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_nat_gateway_network_bytes"></a> [widget\_nat\_gateway\_network\_bytes](#module\_widget\_nat\_gateway\_network\_bytes) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_nat_gateway_network_packets"></a> [widget\_nat\_gateway\_network\_packets](#module\_widget\_nat\_gateway\_network\_packets) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_nat_instance_cpu_credit_balance"></a> [widget\_nat\_instance\_cpu\_credit\_balance](#module\_widget\_nat\_instance\_cpu\_credit\_balance) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_nat_instance_cpu_credit_usage"></a> [widget\_nat\_instance\_cpu\_credit\_usage](#module\_widget\_nat\_instance\_cpu\_credit\_usage) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_nat_instance_cpu_utilization"></a> [widget\_nat\_instance\_cpu\_utilization](#module\_widget\_nat\_instance\_cpu\_utilization) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_nat_instance_network_bytes"></a> [widget\_nat\_instance\_network\_bytes](#module\_widget\_nat\_instance\_network\_bytes) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_nat_instance_network_packets"></a> [widget\_nat\_instance\_network\_packets](#module\_widget\_nat\_instance\_network\_packets) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_response_percentages"></a> [widget\_response\_percentages](#module\_widget\_response\_percentages) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_responses"></a> [widget\_responses](#module\_widget\_responses) | ./../../cloudwatch/metric_widget | n/a |
| <a name="module_widget_target_response_time"></a> [widget\_target\_response\_time](#module\_widget\_target\_response\_time) | ./../../cloudwatch/metric_widget | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.lb_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_eip.public_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_eip_association.public_nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [aws_instance.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_internet_gateway.gateway](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_key_pair.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_lb.lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_nat_gateway.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/nat_gateway) | resource |
| [aws_route.private_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.private_default_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.public_default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route_table.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_route_table_association.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_security_group.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.hosts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.lb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.cloud](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [null_resource.ssm_restart_after_nat_change](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [tls_private_key.bastion](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_private_key.lb_default](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [tls_self_signed_cert.lb_default](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/self_signed_cert) | resource |
| [aws_ami.nat](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_availability_zones.zones](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [cloudinit_config.config](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones_count"></a> [availability\_zones\_count](#input\_availability\_zones\_count) | Number of availability zones the network should span | `number` | `2` | no |
| <a name="input_create"></a> [create](#input\_create) | Should resources be created | `bool` | `true` | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | Enable/disable DNS hostnames in the VPC | `bool` | `false` | no |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | Enable/disable DNS support in the VPC | `bool` | `true` | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Kebab-cased environment name, eg. development, staging, production. | `string` | n/a | yes |
| <a name="input_lb_ssl_policy"></a> [lb\_ssl\_policy](#input\_lb\_ssl\_policy) | SSL policy to set on the HTTPS ALB listener, see https://docs.aws.amazon.com/elasticloadbalancing/latest/application/create-https-listener.html#describe-ssl-policies | `string` | `"ELBSecurityPolicy-TLS-1-2-2017-01"` | no |
| <a name="input_nat_instance"></a> [nat\_instance](#input\_nat\_instance) | Use NAT instances instead of NAT gateways. | `bool` | `false` | no |
| <a name="input_nat_instance_ami_name"></a> [nat\_instance\_ami\_name](#input\_nat\_instance\_ami\_name) | Name of the EC2 AMI used by NAT instances | `string` | `"amzn2-ami-kernel-5.10-hvm-2.0.20240131.0-x86_64-gp2"` | no |
| <a name="input_nat_instance_type"></a> [nat\_instance\_type](#input\_nat\_instance\_type) | EC2 instance type to use to create a NAT instance. | `string` | `"t3.nano"` | no |
| <a name="input_project"></a> [project](#input\_project) | Kebab-cased project name | `string` | n/a | yes |
| <a name="input_project_index"></a> [project\_index](#input\_project\_index) | Unique project number in 0-255 range which will be used to build the VPC CIDR block: 10.{project\_index}.0.0/16 | `number` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources that support them | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_availability_zones"></a> [availability\_zones](#output\_availability\_zones) | The availability zones in which corresponding public and private subnets were created |
| <a name="output_hosts_security_group_arn"></a> [hosts\_security\_group\_arn](#output\_hosts\_security\_group\_arn) | The ARN of the Security Group which should be used by host instances |
| <a name="output_hosts_security_group_id"></a> [hosts\_security\_group\_id](#output\_hosts\_security\_group\_id) | The ID of the Security Group which should be used by host instances |
| <a name="output_http_listener_arn"></a> [http\_listener\_arn](#output\_http\_listener\_arn) | The ARN of the ALB's HTTP Listener |
| <a name="output_https_listener_arn"></a> [https\_listener\_arn](#output\_https\_listener\_arn) | The ARN of the ALB's HTTPS Listener |
| <a name="output_internet_gateway_id"></a> [internet\_gateway\_id](#output\_internet\_gateway\_id) | The ID of the Internet Gateway |
| <a name="output_lb_metrics"></a> [lb\_metrics](#output\_lb\_metrics) | Load balancer related Cloudwatch metrics, see [metrics.tf](./metrics.tf) |
| <a name="output_lb_widgets"></a> [lb\_widgets](#output\_lb\_widgets) | Load balancer related Cloudwatch dashboard widgets, see [widgets.tf](./widgets.tf) |
| <a name="output_load_balancer_arn"></a> [load\_balancer\_arn](#output\_load\_balancer\_arn) | The ARN of the Application Load Balancer |
| <a name="output_load_balancer_domain"></a> [load\_balancer\_domain](#output\_load\_balancer\_domain) | The domain name of the Application Load Balancer |
| <a name="output_load_balancer_id"></a> [load\_balancer\_id](#output\_load\_balancer\_id) | The ID of the Application Load Balancer |
| <a name="output_load_balancer_security_group_arn"></a> [load\_balancer\_security\_group\_arn](#output\_load\_balancer\_security\_group\_arn) | The ARN of the Application Load Balancer's Security Group |
| <a name="output_load_balancer_security_group_id"></a> [load\_balancer\_security\_group\_id](#output\_load\_balancer\_security\_group\_id) | The ID of the Application Load Balancer's Security Group |
| <a name="output_load_balancer_zone_id"></a> [load\_balancer\_zone\_id](#output\_load\_balancer\_zone\_id) | The canonical hosted zone ID of the Application Load Balancer (to be used in a Route 53 Alias record) |
| <a name="output_nat_gateway_metrics"></a> [nat\_gateway\_metrics](#output\_nat\_gateway\_metrics) | NAT gateway Cloudwatch metrics, see [metrics.tf](./metrics.tf) |
| <a name="output_nat_gateway_widgets"></a> [nat\_gateway\_widgets](#output\_nat\_gateway\_widgets) | NAT gateway Cloudwatch dashboard widgets, see [widgets.tf](./widgets.tf) |
| <a name="output_nat_instance_metrics"></a> [nat\_instance\_metrics](#output\_nat\_instance\_metrics) | NAT instance Cloudwatch metrics, see [metrics.tf](./metrics.tf) |
| <a name="output_nat_instance_widgets"></a> [nat\_instance\_widgets](#output\_nat\_instance\_widgets) | NAT instance Cloudwatch dashboard widgets, see [widgets.tf](./widgets.tf) |
| <a name="output_private_blocks"></a> [private\_blocks](#output\_private\_blocks) | The CIDR blocks of private subnets |
| <a name="output_private_subnet_ids"></a> [private\_subnet\_ids](#output\_private\_subnet\_ids) | The IDs of private subnets |
| <a name="output_public_blocks"></a> [public\_blocks](#output\_public\_blocks) | The CIDR blocks of public subnets |
| <a name="output_public_gateway_ips"></a> [public\_gateway\_ips](#output\_public\_gateway\_ips) | The public IP addresses of nat gateways used for outbound traffic |
| <a name="output_public_subnet_ids"></a> [public\_subnet\_ids](#output\_public\_subnet\_ids) | The IDs of public subnets |
| <a name="output_vpc_block"></a> [vpc\_block](#output\_vpc\_block) | The CIDR block of the VPC |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
<!-- END_TF_DOCS -->
<!-- prettier-ignore-end -->

# ECS network

Creates networking resources needed for a standard ECS cluster setup:

1. A single VPC with Internet Gateway
2. Public and private subnet in each availability zone
3. NAT Gateway in each public subnet for outbound traffic
4. Application Load Balancer for inbound traffic with HTTP and HTTPS listeners

# To do

- [ ] S3 bucket for ALB Logs

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |
| `null` | `>= 2.1.2` |
| `tls` | `>= 2.0.1` |

## Inputs

* `availability_zones_count` (`number`, default: `2`)

    Number of availability zones the network should span

* `create` (`bool`, default: `true`)

    Should resources be created

* `enable_dns_hostnames` (`bool`, default: `false`)

    Enable/disable DNS hostnames in the VPC

* `enable_dns_support` (`bool`, default: `true`)

    Enable/disable DNS support in the VPC

* `environment` (`string`, required)

    Kebab-cased environment name, eg. development, staging, production.

* `nat_instance` (`bool`, default: `false`)

    Use NAT instances instead of NAT gateways.

* `nat_instance_type` (`string`, default: `"t3.nano"`)

    EC2 instance type to use to create a NAT instance.

* `project` (`string`, required)

    Kebab-cased project name

* `project_index` (`number`, required)

    Unique project number in 0-255 range which will be used to build the VPC CIDR block: 10.{project_index}.0.0/16

* `tags` (`map(string)`, default: `{}`)

    Tags to add to resources that support them



## Outputs

* `availability_zones`

    The availability zones in which corresponding public and private subnets were created

* `hosts_security_group_arn`

    The ARN of the Security Group which should be used by host instances

* `hosts_security_group_id`

    The ID of the Security Group which should be used by host instances

* `http_listener_arn`

    The ARN of the ALB's HTTP Listener

* `https_listener_arn`

    The ARN of the ALB's HTTPS Listener

* `internet_gateway_id`

    The ID of the Internet Gateway

* `lb_metrics`

    Load balancer related Cloudwatch metrics, see [metrics.tf](./metrics.tf)

* `lb_widgets`

    Load balancer related Cloudwatch dashboard widgets, see [widgets.tf](./widgets.tf)

* `load_balancer_arn`

    The ARN of the Application Load Balancer

* `load_balancer_domain`

    The domain name of the Application Load Balancer

* `load_balancer_id`

    The ID of the Application Load Balancer

* `load_balancer_security_group_arn`

    The ARN of the Application Load Balancer's Security Group

* `load_balancer_security_group_id`

    The ID of the Application Load Balancer's Security Group

* `load_balancer_zone_id`

    The canonical hosted zone ID of the Application Load Balancer (to be used in a Route 53 Alias record)

* `nat_gateway_metrics`

    NAT gateway Cloudwatch metrics, see [metrics.tf](./metrics.tf)

* `nat_gateway_widgets`

    NAT gateway Cloudwatch dashboard widgets, see [widgets.tf](./widgets.tf)

* `nat_instance_metrics`

    NAT instance Cloudwatch metrics, see [metrics.tf](./metrics.tf)

* `nat_instance_widgets`

    NAT instance Cloudwatch dashboard widgets, see [widgets.tf](./widgets.tf)

* `private_blocks`

    The CIDR blocks of private subnets

* `private_subnet_ids`

    The IDs of private subnets

* `public_blocks`

    The CIDR blocks of public subnets

* `public_gateway_ips`

    The public IP addresses of nat gateways used for outbound traffic

* `public_subnet_ids`

    The IDs of public subnets

* `vpc_block`

    The CIDR block of the VPC

* `vpc_id`

    The ID of the VPC

# ECS network

Creates networking resources needed for a standard ECS cluster setup:

1. A single VPC with Internet Gateway
2. Public and private subnet in each availability zone
3. NAT Gateway in each public subnet for outbound traffic
4. Application Load Balancer for inbound traffic with HTTP and HTTPS listeners
5. Bastion hosts for accessing hosts within the private subnets

# To do

- [ ] S3 bucket for ALB Logs

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.22.0` |
| `tls` | `>= 2.0.1` |

## Inputs

* `availability_zones_count` (`number`, default: `2`)

    Number of availability zones the network should span

* `bastion_ingress_cidr_blocks` (`list(string)`, default: `["0.0.0.0/0"]`)

    CIDR blocks from where you should be able to access the bastion host

* `create` (`bool`, default: `true`)

    Should resources be created

* `environment` (`string`, required)

    Kebab-cased environment name, eg. development, staging, production.

* `nat_instance` (`bool`, required)

    Use NAT instances instead of NAT gateways.

* `nat_instance_type` (`string`, default: `"t3.nano"`)

    EC2 instance type to use to create a NAT instance.

* `project` (`string`, required)

    Kebab-cased project name

* `project_index` (`number`, required)

    Unique project number in 0-255 range which will be used to build the VPC CIDR block: 10.{project_index}.0.0/16

* `tags` (`map(string)`, required)

    Tags to add to resources that support them



## Outputs

* `availability_zones`

    The availability zones in which corresponding public and private subnets were created

* `bastion_key_name`

    Name of the AWS key pair that can be used to access the bastion

* `bastion_private_ips`

    Private IP addresses of bastion hosts

* `bastion_private_key`

    Private key which can be used to SSH onto a bastion host

* `bastion_public_ips`

    Public IP addresses of bastion hosts

* `bastion_public_key_openssh`

    Public key to add to authorized_keys on machines which should be accessible from the bastion

* `bastions_security_group_arn`

    The ARN of the Security Group which should be used by bastion instances

* `bastions_security_group_id`

    The ID of the Security Group which should be used by bastion instances

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

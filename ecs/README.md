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

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |

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

* `arn`

    Cluster ARN

* `availability_zones`

    The availability zones in which corresponding public and private subnets were created

* `host_profile_arn`

    ECS host instance profile ARN

* `host_profile_id`

    ECS host instance profile ID

* `host_profile_name`

    ECS host instance profile name

* `host_role_arn`

    ECS host role ARN

* `host_role_name`

    ECS host role name

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

    Load balancer related Cloudwatch metrics, see [network/metrics.tf](./network/metrics.tf)

* `lb_widgets`

    Load balancer related Cloudwatch dashboard widgets, see [network/widgets.tf](./network/widgets.tf)

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

* `metrics`

    ECS cluster Cloudwatch metrics, see [metrics.tf](./metrics.tf) for details

* `name`

    Cluster name

* `nat_gateway_metrics`

    NAT gateway related Cloudwatch metrics, see [network/metrics.tf](./network/metrics.tf)

* `nat_gateway_widgets`

    NAT gateway related Cloudwatch dashboard widgets, see [network/widgets.tf](./network/widgets.tf)

* `nat_instance_metrics`

    NAT instance related Cloudwatch metrics, see [network/metrics.tf](./network/metrics.tf)

* `nat_instance_widgets`

    NAT instance related Cloudwatch dashboard widgets, see [network/widgets.tf](./network/widgets.tf)

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

* `web_service_role_arn`

    ECS web service task role ARN

* `web_service_role_name`

    ECS web service task role name

* `widgets`

    ECS cluster Cloudwatch dashboard widgets, see [widgets.tf](./widgets.tf) for details

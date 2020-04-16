# ecs/host_group

Creates an auto-scaling group of EC2 instances which will join the given ECS cluster.

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |
| `template` | `>= 2.1.2` |

## Inputs

* `ami_name` (`string`, default: `"amzn2-ami-ecs-hvm-2.0.20200319-x86_64-ebs"`)

    ECS-optimized Amazon Linux AMI name to use

* `cluster_name` (`string`, required)

    Name of the ECS cluster to attach to

* `cpu_credits` (`string`, default: `"standard"`)

    The credit option for CPU usage. Can be 'standard' or 'unlimited'.

* `create` (`bool`, default: `true`)

    Should resources be created

* `detailed_monitoring` (`bool`, default: `true`)

    Whether to enable detailed monitoring on EC2 instances

* `environment` (`string`, required)

    Kebab-cased environment name, eg. development, staging, production.

* `instance_profile` (`string`, required)

    Name of the instance profile created by the ecs/worker_role module

* `instance_type` (`string`, required)

    EC2 instance type

* `max_size` (`number`, default: `null`)

    The maximum size of the auto scale group, defaults to size

* `min_size` (`number`, default: `null`)

    The minimum size of the auto scale group, defaults to size

* `name` (`string`, default: `"hosts"`)

    Kebab-cased host name to distinguish different types of hosts in the same environment

* `project` (`string`, required)

    Kebab-cased project name

* `security_group_id` (`string`, required)

    ID of the security group created by ecs/network module for host instances

* `size` (`number`, required)

    The number of Amazon EC2 instances that should be running in the group

* `subnet_ids` (`list(string)`, required)

    Ids of subnets hosts should be launched in, private subnets created by the ecs/network module

* `tags` (`map(string)`, default: `{}`)

    Tags to add to resources that support them



## Outputs

* `arn`

    Autoscaling group ARN

* `id`

    Autoscaling group id

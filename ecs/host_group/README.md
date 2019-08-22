# ecs/host_group

Creates an auto-scaling group of EC2 instances which will join the given ECS cluster.

## Inputs

| Name                | Description                                                                                                  |  Type  |                    Default                    | Required |
| ------------------- | ------------------------------------------------------------------------------------------------------------ | :----: | :-------------------------------------------: | :------: |
| ami\_name           | ECS-optimized Amazon Linux AMI name to use                                                                   | string | `"amzn2-ami-ecs-hvm-2.0.20190603-x86_64-ebs"` |    no    |
| bastion\_key\_name  | Name of the bastion key which will be added to authorized_keys, so you can ssh to the host from the bastion. | string |                      n/a                      |   yes    |
| cluster\_name       | Name of the ECS cluster to attach to                                                                         | string |                      n/a                      |   yes    |
| environment         | Kebab-cased environment name, eg. development, staging, production.                                          | string |                      n/a                      |   yes    |
| instance\_profile   | Name of the instance profile created by the ecs/worker_role module                                           | string |                      n/a                      |   yes    |
| instance\_type      | EC2 instance type                                                                                            | string |                      n/a                      |   yes    |
| max\_size           | The maximum size of the auto scale group, defaults to size                                                   | string |                     `""`                      |    no    |
| min\_size           | The minimum size of the auto scale group, defaults to size                                                   | string |                     `""`                      |    no    |
| name                | Kebab-cased host name to distinguish different types of hosts in the same environment                        | string |                   `"hosts"`                   |    no    |
| project             | Kebab-cased project name                                                                                     | string |                      n/a                      |   yes    |
| security\_group\_id | ID of the security group created by ecs/network module for host instances                                    | string |                      n/a                      |   yes    |
| size                | The number of Amazon EC2 instances that should be running in the group                                       | string |                      n/a                      |   yes    |
| subnet\_ids         | Ids of subnets hosts should be launched in, private subnets created by the ecs/network module                |  list  |                      n/a                      |   yes    |
| tags                | Tags to add to resources that support them                                                                   |  map   |                    `<map>`                    |    no    |

## Outputs

| Name                   | Description           |
| ---------------------- | --------------------- |
| arn                    | Autoscaling group ARN |
| id                     | Autoscaling group id  |
| instance\_ids          |                       |
| instance\_private\_ips |                       |


# ECS

Modules for setting up an ECS-based docker container cluster.

Based on [AWS reference architecture](https://github.com/aws-samples/ecs-refarch-cloudformation) and [segmentio/stack](https://github.com/segmentio/stack)

## Inputs

| Name                           | Description                                                                                                    |  Type  | Default  | Required |
| ------------------------------ | -------------------------------------------------------------------------------------------------------------- | :----: | :------: | :------: |
| availability\_zones\_count     | Number of availability zones the network should span                                                           | string |  `"2"`   |    no    |
| bastion\_ingress\_cidr\_blocks | CIDR blocks from where you should be able to access the bastion host                                           |  list  | `<list>` |    no    |
| environment                    | Kebab-cased environment name, eg. development, staging, production.                                            | string |   n/a    |   yes    |
| project                        | Kebab-cased project name                                                                                       | string |   n/a    |   yes    |
| project\_index                 | Unique project number in 0-255 range which will be used to build the VPC CIDR block: 10.{project_index}.0.0/16 | string |   n/a    |   yes    |
| tags                           | Tags to add to resources that support them                                                                     |  map   | `<map>`  |    no    |

## Outputs

| Name                                 | Description                                                                                           |
| ------------------------------------ | ----------------------------------------------------------------------------------------------------- |
| arn                                  |                                                                                                       |
| availability\_zones                  | The availability zones in which corresponding public and private subnets were created                 |
| bastion\_key\_name                   | Name of the AWS key pair that can be used to access the bastion                                       |
| bastion\_private\_ips                | Private IP addresses of bastion hosts                                                                 |
| bastion\_private\_key                | Private key which can be used to SSH onto a bastion host                                              |
| bastion\_public\_ips                 | Public IP addresses of bastion hosts                                                                  |
| bastion\_public\_key\_openssh        | Public key to add to authorized_keys on machines which should be accessible from the bastion          |
| bastions\_security\_group\_arn       | The ARN of the Security Group which should be used by bastion instances                               |
| bastions\_security\_group\_id        | The ID of the Security Group which should be used by bastion instances                                |
| host\_profile\_arn                   | ECS host instance profile ARN                                                                         |
| host\_profile\_id                    | ECS host instance profile ID                                                                          |
| host\_profile\_name                  | ECS host instance profile name                                                                        |
| host\_role\_arn                      | ECS host role ARN                                                                                     |
| host\_role\_name                     | ECS host role name                                                                                    |
| hosts\_security\_group\_arn          | The ARN of the Security Group which should be used by host instances                                  |
| hosts\_security\_group\_id           | The ID of the Security Group which should be used by host instances                                   |
| http\_listener\_arn                  | The ARN of the ALB's HTTP Listener                                                                    |
| https\_listener\_arn                 | The ARN of the ALB's HTTPS Listener                                                                   |
| internet\_gateway\_id                | The ID of the Internet Gateway                                                                        |
| load\_balancer\_arn                  | The ARN of the Application Load Balancer                                                              |
| load\_balancer\_domain               | The domain name of the Application Load Balancer                                                      |
| load\_balancer\_id                   | The ID of the Application Load Balancer                                                               |
| load\_balancer\_security\_group\_arn | The ARN of the Application Load Balancer's Security Group                                             |
| load\_balancer\_security\_group\_id  | The ID of the Application Load Balancer's Security Group                                              |
| load\_balancer\_zone\_id             | The canonical hosted zone ID of the Application Load Balancer (to be used in a Route 53 Alias record) |
| name                                 |                                                                                                       |
| private\_blocks                      | The CIDR blocks of private subnets                                                                    |
| private\_subnet\_ids                 | The IDs of private subnets                                                                            |
| public\_blocks                       | The CIDR blocks of public subnets                                                                     |
| public\_gateway\_ips                 | The public IP addresses of nat gateways used for outbound traffic                                     |
| public\_subnet\_ids                  | The IDs of public subnets                                                                             |
| vpc\_block                           | The CIDR block of the VPC                                                                             |
| vpc\_id                              | The ID of the VPC                                                                                     |
| web\_service\_role\_arn              | ECS web service task role ARN                                                                         |
| web\_service\_role\_name             | ECS web service task role name                                                                        |


# ECS network

Creates networking resources needed for a standard ECS cluster setup:

1. A single VPC with Internet Gateway
2. Public and private subnet in each availability zone
3. NAT Gateway in each public subnet for outbound traffic
4. Application Load Balancer for inbound traffic

# To do

- [ ] S3 bucket for ALB Logs

## Inputs

| Name                       | Description                                                                                                    |  Type  | Default | Required |
| -------------------------- | -------------------------------------------------------------------------------------------------------------- | :----: | :-----: | :------: |
| availability\_zones\_count | Number of availability zones the network should span                                                           | string |  `"2"`  |    no    |
| environment                | Kebab-cased environment name, eg. development, staging, production.                                            | string |   n/a   |   yes    |
| project                    | Kebab-cased project name                                                                                       | string |   n/a   |   yes    |
| project\_index             | Unique project number in 0-255 range which will be used to build the VPC CIDR block: 10.{project_index}.0.0/16 | string |   n/a   |   yes    |
| tags                       | Tags to add to resources that support them                                                                     |  map   | `<map>` |    no    |

## Outputs

| Name                                 | Description                                                                                           |
| ------------------------------------ | ----------------------------------------------------------------------------------------------------- |
| availability\_zones                  | The availability zones in which corresponding public and private subnets were created                 |
| internet\_gateway\_id                | The ID of the Internet Gateway                                                                        |
| load\_balancer\_arn                  | The ARN of the Application Load Balancer                                                              |
| load\_balancer\_domain               | The domain name of the Application Load Balancer                                                      |
| load\_balancer\_id                   | The ID of the Application Load Balancer                                                               |
| load\_balancer\_security\_group\_arn | The ARN of the Application Load Balancer's Security Group                                             |
| load\_balancer\_security\_group\_id  | The ID of the Application Load Balancer's Security Group                                              |
| load\_balancer\_zone\_id             | The canonical hosted zone ID of the Application Load Balancer (to be used in a Route 53 Alias record) |
| private\_blocks                      | The CIDR blocks of private subnets                                                                    |
| private\_subnet\_ids                 | The IDs of private subnets                                                                            |
| public\_blocks                       | The CIDR blocks of public subnets                                                                     |
| public\_gateway\_ips                 | The public IP addresses of nat gateways used for outbound traffic                                     |
| public\_subnet\_ids                  | The IDs of public subnets                                                                             |
| vpc\_block                           | The CIDR block of the VPC                                                                             |
| vpc\_id                              | The ID of the VPC                                                                                     |
| workers\_security\_group\_arn        | The ARN of the Security Group which should be used by worker instances                                |
| workers\_security\_group\_id         | The ID of the Security Group which should be used by worker instances                                 |


# ECS Host

Creates a single EC2 instance that will join the given ECS cluster.
## Inputs

| Name                | Description                                                                                                  |  Type  | Default | Required |
| ------------------- | ------------------------------------------------------------------------------------------------------------ | :----: | :-----: | :------: |
| bastion\_key\_name  | Name of the bastion key which will be added to authorized_keys, so you can ssh to the host from the bastion. | string |   n/a   |   yes    |
| cluster\_name       | Name of the ECS cluster to attach to                                                                         | string |   n/a   |   yes    |
| environment         | Kebab-cased environment name, eg. development, staging, production.                                          | string |   n/a   |   yes    |
| instance\_profile   | Name of the instance profile created by the ecs/worker_role module                                           | string |   n/a   |   yes    |
| instance\_type      | EC2 instance type                                                                                            | string |   n/a   |   yes    |
| name                | Kebab-cased worker name, eg. {project}-{environment}-worker                                                  | string |   n/a   |   yes    |
| project             | Kebab-cased project name                                                                                     | string |   n/a   |   yes    |
| security\_group\_id | ID of the security group created by ecs/network module for worker instances                                  | string |   n/a   |   yes    |
| subnet\_id          | Subnet id the instance should run in, one of the private subnets created by the ecs/network module           | string |   n/a   |   yes    |
| tags                | Tags to add to resources that support them                                                                   |  map   | `<map>` |    no    |


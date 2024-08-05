# Elasticache Redis

Creates an Elasticache Redis cluster

## Inputs

| Name                 | Description                                                                                         |  Type   |       Default        | Required |
| -------------------- | --------------------------------------------------------------------------------------------------- | :-----: | :------------------: | :------: |
| environment          | Kebab-cased environment name, eg. development, staging, production                                  | string  |         n/a          |   yes    |
| id                   | Elasticache cluster id, defaults to project-environment, 1 to 20 alphanumeric characters or hyphens | string  |         `""`         |    no    |
| instance_count       | Number of instances to create in the cluster                                                        | string  |        `"1"`         |    no    |
| instance_type        | The instance type of the Elasticache cluster, eg. cache.t2.micro                                    | string  |         n/a          |   yes    |
| parameter_group_name | Elasticache parameter group, needs to be adjusted along with the version                            | string  | `"default.redis5.0"` |    no    |
| port                 | The port on which Redis should accept connections                                                   | string  |       `"6379"`       |    no    |
| project              | Kebab-cased project name                                                                            | string  |         n/a          |   yes    |
| redis_version        | Elasticache Redis engine version                                                                    | string  |      `"5.0.6"`       |    no    |
| security_group_ids   | Security group ids which should have access to Redis                                                |  list   |       `<list>`       |    no    |
| subnet_ids           | VPC subnet IDs in which Redis should be created                                                     |  list   |         n/a          |   yes    |
| tags                 | Tags to add to resources that support them                                                          |   map   |       `<map>`        |    no    |
| vpc_id               | VPC ID in which Redis should be created                                                             | string  |         n/a          |   yes    |
| apply_immediately    | Whether to apply changes immediately, possibly incuring downtime                                    | boolean |        `true`        |    no    |

## Outputs

| Name  | Description                         |
| ----- | ----------------------------------- |
| host  | First Redis instance host           |
| hosts | Redis hosts                         |
| port  | Redis port                          |
| url   | First Redis instance connection url |
| urls  | Redis connection urls               |

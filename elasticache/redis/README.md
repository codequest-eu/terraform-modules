# Elasticache Redis

Creates an Elasticache Redis cluster

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.22.0` |
| `template` | `>= 2.1.2` |

## Inputs

* `create` (`bool`, default: `true`)

    Should resources be created

* `environment` (`string`, required)

    Kebab-cased environment name, eg. development, staging, production

* `id` (`string`, required)

    Elasticache cluster id, defaults to project-environment, 1 to 20 alphanumeric characters or hyphens

* `instance_count` (`number`, default: `1`)

    Number of instances to create in the cluster

* `instance_type` (`string`, required)

    The instance type of the Elasticache cluster, eg. cache.t2.micro

* `parameter_group_name` (`string`, default: `"default.redis5.0"`)

    Elasticache parameter group, needs to be adjusted along with the version

* `port` (`number`, default: `6379`)

    The port on which Redis should accept connections

* `project` (`string`, required)

    Kebab-cased project name

* `redis_version` (`string`, default: `"5.0.3"`)

    Elasticache Redis engine version

* `security_group_ids` (`list(string)`, required)

    Security group ids which should have access to Redis

* `subnet_ids` (`list(string)`, required)

    VPC subnet IDs in which Redis should be created

* `tags` (`map(string)`, required)

    Tags to add to resources that support them

* `vpc_id` (`string`, required)

    VPC ID in which Redis should be created



## Outputs

* `host`

    First Redis instance host

* `hosts`

    Redis hosts

* `port`

    Redis port

* `url`

    First Redis instance connection url

* `urls`

    Redis connection urls

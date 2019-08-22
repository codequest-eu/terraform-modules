# ecs/task/log_group

Creates a CloudWatch log group for a container and outputs container logging configuration.

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.22.0` |

## Inputs

* `container` (`string`, required)

    Container name within the task definition

* `create` (`bool`, default: `true`)

    Should resources be created

* `environment` (`string`, required)

    Kebab-cased environment name, eg. development, staging, production.

* `project` (`string`, required)

    Kebab-cased project name

* `tags` (`map(string)`, required)

    Tags to add to resources that support them

* `task` (`string`, required)

    ECS task definition name



## Outputs

* `arn`

    CloudWatch log group ARN

* `container_config`

    Container definition logging configuration

* `container_config_json`

    Container definition logging configuration JSON

* `name`

    CloudWatch log group name

# ECS Access

Creates IAM resources needed to run host instances and services in the ECS cluster.

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |

## Inputs

* `create` (`bool`, default: `true`)

    Should resources be created

* `environment` (`string`, required)

    Kebab-cased environment name, eg. development, staging, production.

* `project` (`string`, required)

    Kebab-cased project name



## Outputs

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

* `web_service_role_arn`

    ECS web service task role ARN

* `web_service_role_name`

    ECS web service task role name

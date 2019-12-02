# ecs/services/worker

Creates an ECS service for background workers

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |

## Inputs

* `cluster_arn` (`string`, required)

    ARN of the ECS cluster to create the service in

* `create` (`bool`, default: `true`)

    Should resources be created

* `deployment_max_percent` (`number`, default: `200`)

    The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. Rounded down to get the maximum number of running tasks.

* `deployment_min_percent` (`number`, default: `50`)

    The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment. Rounded up to get the minimum number of running tasks.

* `desired_count` (`number`, default: `2`)

    The number of instances of the task definition to place and keep running.

* `launch_type` (`string`, default: `"EC2"`)

    The launch type on which to run your service. Either EC2 or FARGATE.

* `name` (`string`, required)

    ECS service name

* `task_definition_arn` (`string`, required)

    ECS task definition ARN to run as a service



## Outputs

* `id`

    Service id

# ecs/services/web

Creates an ECS service exposed to the internet using an Application Load Balancer.

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |

## Inputs

* `cluster_arn` (`string`, required)

    ARN of the ECS cluster to create the service in

* `container` (`string`, required)

    Container to forward requests to, defaults to service name

* `container_port` (`number`, default: `80`)

    Port on which the container is listening

* `create` (`bool`, default: `true`)

    Should resources be created

* `deployment_max_percent` (`number`, default: `200`)

    The upper limit (as a percentage of the service's desiredCount) of the number of running tasks that can be running in a service during a deployment. Rounded down to get the maximum number of running tasks.

* `deployment_min_percent` (`number`, default: `50`)

    The lower limit (as a percentage of the service's desiredCount) of the number of running tasks that must remain running and healthy in a service during a deployment. Rounded up to get the minimum number of running tasks.

* `deregistration_delay` (`number`, default: `30`)

    Connection draining time in seconds.

* `desired_count` (`number`, default: `2`)

    The number of instances of the task definition to place and keep running.

* `healthcheck_interval` (`number`, default: `5`)

    How often, in seconds, healtchecks should be sent.

* `healthcheck_path` (`string`, default: `"/healthcheck"`)

    Healthcheck endpoint path

* `healthcheck_status` (`number`, default: `200`)

    Healthy response status

* `healthcheck_timeout` (`number`, default: `2`)

    Healthcheck request timeout, in seconds.

* `healthy_threshold` (`number`, default: `2`)

    The number of consecutive health checks successes required before considering an unhealthy target healthy

* `launch_type` (`string`, default: `"EC2"`)

    The launch type on which to run your service. Either EC2 or FARGATE.

* `listener_arn` (`string`, required)

    ALB listener ARN

* `name` (`string`, required)

    ECS service name

* `role_arn` (`string`, required)

    ARN of the IAM role that allows Amazon ECS to make calls to your load balancer on your behalf.

* `rule_domain` (`string`, default: `"*"`)

    

* `rule_path` (`string`, default: `"/*"`)

    

* `slow_start` (`number`, required)

    The amount time to warm up before the load balancer sends the full share of requests.

* `target_group_name` (`string`, required)

    Load balancer target group name, defaults to {cluster name}-{service name}. Max 32 characters.

* `task_definition_arn` (`string`, required)

    ECS task definition ARN to run as a service

* `unhealthy_threshold` (`number`, default: `2`)

    The number of consecutive health check failures required before considering the target unhealthy

* `vpc_id` (`string`, required)

    VPC id



## Outputs

* `id`

    Service id

* `target_group_arn`

    Load balancer target group ARN

* `target_group_name`

    Load balancer target group name

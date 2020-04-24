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

* `container` (`string`, default: `null`)

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

    Domain to route to the service

* `rule_path` (`string`, default: `"/*"`)

    Path pattern to route to the service

* `slow_start` (`number`, default: `0`)

    The amount time to warm up before the load balancer sends the full share of requests.

* `target_group_name` (`string`, default: `null`)

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

* `metric_2xx_responses`

    Cloudwatch metric tracking the number of 2xx responses

* `metric_2xx_responses_ratio`

    Cloudwatch metric tracking percentage of 2xx responses

* `metric_3xx_responses`

    Cloudwatch metric tracking the number of 3xx responses

* `metric_3xx_responses_ratio`

    Cloudwatch metric tracking percentage of 3xx responses

* `metric_4xx_responses`

    Cloudwatch metric tracking the number of 4xx responses

* `metric_4xx_responses_ratio`

    Cloudwatch metric tracking percentage of 4xx responses

* `metric_5xx_responses`

    Cloudwatch metric tracking the number of 5xx responses

* `metric_5xx_responses_ratio`

    Cloudwatch metric tracking percentage of 5xx responses

* `metric_average_response_time`

    Cloudwatch metric tracking average response time

* `metric_max_response_time`

    Cloudwatch metric tracking maximum response time

* `metric_p50_response_time`

    Cloudwatch metric tracking median response time

* `metric_p90_response_time`

    Cloudwatch metric tracking 90th percentile response time

* `metric_p95_response_time`

    Cloudwatch metric tracking 95th percentile response time

* `metric_p99_response_time`

    Cloudwatch metric tracking 99th percentile response time

* `metric_responses`

    Cloudwatch metric tracking total number of responses

* `target_group_arn`

    Load balancer target group ARN

* `target_group_name`

    Load balancer target group name

* `widget_response_ratios`

    Cloudwatch dashboard widget that shows a breakdown of response status code percentages

* `widget_response_time`

    Cloudwatch dashboard widget that shows a breakdown of response time percentiles

* `widget_responses`

    Cloudwatch dashboard widget that shows a breakdown of response status codes

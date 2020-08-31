# ecs/services/statsd

Adds a statsd server, using cloudwatch agent, to each ECS instance

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |

## Inputs

* `aggregation_interval` (`number`, default: `60`)

    How often should the metrics be aggregated in seconds

* `cluster_arn` (`string`, required)

    ARN of the ECS cluster to add the daemon to

* `collection_interval` (`number`, default: `10`)

    How often should the metrics be collected in seconds

* `create` (`bool`, default: `true`)

    Whether any resources should be created

* `debug` (`bool`, default: `false`)

    Whether to enable cloudwatch agent debug mode

* `name` (`string`, default: `"statsd"`)

    Name for the service and task definition

* `port` (`number`, default: `8125`)

    Port to listen on on each ECS instance

* `tags` (`map(string)`, default: `{}`)

    Tags to add to resources



## Outputs

* `address`

    StatsD address

* `host`

    StatsD server host - IP of the docker host

* `port`

    StatsD server port on the docker host

* `service_id`

    ECS service id

* `service_name`

    ECS service name

* `task_arn`

    Task definition ARN

* `task_family`

    Task definition family

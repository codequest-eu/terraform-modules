# cloudwatch/metric

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |

## Inputs

* `color` (`string`, default: `null`)

    Color to use in graphs

* `dimensions` (`map(string)`, default: `{}`)

    Additional metric filters, eg. `{ InstanceId = i-abc123 }`

* `id` (`string`, default: `null`)

    Metric id to use in expressions

* `label` (`string`, default: `null`)

    Human-friendly metric description

* `name` (`string`, required)

    Name of the metric, eg. `CPUUtilization`

* `namespace` (`string`, required)

    Namespace of the metric, eg. `AWS/EC2`

* `period` (`number`, default: `60`)

    Metric aggregation period in seconds

* `stat` (`string`, default: `"Average"`)

    Metric aggregation function



## Outputs

* `alarm_metric`

    Object to use for a aws_cloudwatch_alarm metric block

* `alarm_metric_query`

    Object to use for a aws_cloudwatch_alarm metric_query block

* `dimensions`

    Additional metric filters, eg. `{ InstanceId = i-abc123 }`

* `graph_metric`

    Path + options to add this metric to a cloudwatch graph

* `graph_metric_options`

    Options object to use for this metric in a cloudwatch graph

* `graph_metric_path`

    Path to use to add this metric to a cloudwatch graph

* `id`

    Metric id to use in expressions

* `label`

    Human-friendly metric description

* `name`

    Name of the metric, eg. `CPUUtilization`

* `namespace`

    Namespace of the metric, eg. `AWS/EC2`

* `period`

    Metric aggregation period in seconds

* `stat`

    Metric aggregation function

# cloudwatch/metric_expression

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |

## Inputs

* `color` (`string`, default: `null`)

    Color to use in graphs

* `expression` (`string`, required)

    Metric expression, eg. 'm1 + m2'

* `id` (`string`, default: `null`)

    Metric id to use in expressions

* `label` (`string`, default: `null`)

    Human-friendly metric description



## Outputs

* `alarm_metric`

    Object to use for a aws_cloudwatch_alarm metric block

* `alarm_metric_query`

    Object to use for a aws_cloudwatch_alarm metric_query block

* `expression`

    Metric expression, eg. 'm1 + m2'

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

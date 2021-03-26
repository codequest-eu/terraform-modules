# cloudwatch/metric

<!-- BEGIN_TF_DOCS -->

## Versions

| Provider  | Requirements |
| --------- | ------------ |
| terraform | `>= 0.12`    |

## Inputs

- `color` (`string`, default: `null`)

  Color to use in graphs

- `dimensions` (`map(string)`, default: `{}`)

  Additional metric filters, eg. `{ InstanceId = i-abc123 }`

- `label` (`string`, default: `null`)

  Human-friendly metric description

- `name` (`string`, required)

  Name of the metric, eg. `CPUUtilization`

- `namespace` (`string`, required)

  Namespace of the metric, eg. `AWS/EC2`

- `period` (`number`, default: `60`)

  Metric aggregation period in seconds

- `stat` (`string`, default: `"Average"`)

  Metric aggregation function

## Outputs

- `color`

  Metric color to use in graphs

- `dimensions`

  Additional metric filters, eg. `{ InstanceId = i-abc123 }`

- `id`

  Metric id to use in expressions

- `label`

  Human-friendly metric description

- `name`

  Name of the metric, eg. `CPUUtilization`

- `namespace`

  Namespace of the metric, eg. `AWS/EC2`

- `period`

  Metric aggregation period in seconds

- `stat`

  Metric aggregation function

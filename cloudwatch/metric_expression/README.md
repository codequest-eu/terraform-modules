# cloudwatch/metric_expression

<!-- BEGIN_TF_DOCS -->

## Versions

| Provider  | Requirements |
| --------- | ------------ |
| terraform | `>= 0.12`    |

## Inputs

- `color` (`string`, default: `null`)

  Color to use in graphs

- `expression` (`string`, required)

  Metric expression, eg. 'm1 + m2'

- `label` (`string`, default: `null`)

  Human-friendly metric description

## Outputs

- `color`

  Metric color to use in graphs

- `expression`

  Metric expression, eg. 'm1 + m2'

- `id`

  Metric id to use in expressions

- `label`

  Human-friendly metric description

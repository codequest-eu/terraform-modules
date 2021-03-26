# cloudwatch/alarm

<!-- BEGIN_TF_DOCS -->

## Versions

| Provider  | Requirements  |
| --------- | ------------- |
| terraform | (any version) |
| `aws`     | (any version) |

## Inputs

- `condition` (`tuple([string, string, any])`, required)

  Alarm trigger condition as a `[metric_id, operator, threshold]` tuple, eg. `['m1', '<', 0]`.

  Supported operators:

  |      |                                                       |
  | ---- | ----------------------------------------------------- |
  | `<`  | `LessThanThreshold` or `LessThanLowerThreshold`       |
  | `<=` | `LessThanOrEqualToThreshold`                          |
  | `>`  | `GreaterThanThreshold` or `GreaterThanUpperThreshold` |
  | `>=` | `GreaterThanOrEqualToThreshold`                       |
  | `<>` | `LessThanLowerOrGreaterThanUpperThreshold`            |

  For anomaly detection `threshold` should be the id of the `ANOMALY_DETECTION_BAND` function.

- `condition_period` (`tuple([number, number])`, default: `[1,1]`)

      How many (N) periods have to meet the condition within the last M periods

  to trigger the alarm, as a `[N, M]` tuple,
  eg. `[3, 4]` will require the condition to be met at least 3 times in the last 4 periods

- `create` (`bool`, default: `true`)

  Should resources be created

- `description` (`string`, default: `""`)

  Alarm description

- `metrics` (`any`, required)

  Metrics used by the alarm condition

- `name` (`string`, required)

  Alarm name

- `no_data_actions` (`list(string)`, default: `[]`)

  ARNs of actions that should be triggered when there's missing data

- `no_data_behavior` (`string`, default: `"missing"`)

  What to do with missing data, one of 'missing', 'ignore', 'breaching', 'notBreaching'

- `off_actions` (`list(string)`, default: `[]`)

  ARNs of actions that should be triggered when the alarm goes off

- `on_actions` (`list(string)`, default: `[]`)

  ARNs of actions that should be triggered when the alarm goes on

- `tags` (`map(string)`, default: `{}`)

  Tags to add to resources that support them

## Outputs

- `arn`

  Alarm ARN

- `id`

  Alarm healthcheck id

- `name`

  Alarm name

variable "create" {
  description = "Should resources be created"
  type        = bool
  default     = true
}

variable "name" {
  description = "Alarm name"
  type        = string
}

variable "description" {
  description = "Alarm description"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to add to resources that support them"
  type        = map(string)
  default     = {}
}

variable "condition" {
  description = <<EOF
Alarm trigger condition as a `[metric_id, operator, threshold]` tuple, eg. `['m1', '<', 0]`.

    Supported operators:

    |||
    |-|-|
    | `<` | `LessThanThreshold` or `LessThanLowerThreshold` |
    | `<=` | `LessThanOrEqualToThreshold` |
    | `>` | `GreaterThanThreshold` or `GreaterThanUpperThreshold` |
    | `>=` | `GreaterThanOrEqualToThreshold` |
    | `<>` | `LessThanLowerOrGreaterThanUpperThreshold` |

    For anomaly detection `threshold` should be the id of the `ANOMALY_DETECTION_BAND` function.
  EOF
  type        = tuple([string, string, any])
}

variable "condition_period" {
  description = <<EOF
How many (N) periods have to meet the condition within the last M periods
to trigger the alarm, as a `[N, M]` tuple,
eg. `[3, 4]` will require the condition to be met at least 3 times in the last 4 periods
EOF
  type        = tuple([number, number])
  default     = [1, 1]
}

variable "metrics" {
  description = "Metrics used by the alarm condition"
  type        = any
}

variable "on_actions" {
  description = "ARNs of actions that should be triggered when the alarm goes on"
  type        = list(string)
  default     = []
}

variable "off_actions" {
  description = "ARNs of actions that should be triggered when the alarm goes off"
  type        = list(string)
  default     = []
}

variable "no_data_actions" {
  description = "ARNs of actions that should be triggered when there's missing data"
  type        = list(string)
  default     = []
}

variable "no_data_behavior" {
  description = "What to do with missing data, one of 'missing', 'ignore', 'breaching', 'notBreaching'"
  type        = string
  default     = "missing"
}

# cloudwatch/alarm_widget

Prepares an alarm widget object for `cloudwatch/dashboard`

https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/CloudWatch-Dashboard-Body-Structure.html#CloudWatch-Dashboard-Properties-Widgets-Structure

<!-- BEGIN_TF_DOCS -->

## Versions

| Provider  | Requirements |
| --------- | ------------ |
| terraform | `>= 0.12`    |

## Inputs

- `alarm_arn` (`string`, required)

  ARN of the alarm to display

- `dimensions` (`tuple([number, number])`, default: `[6,6]`)

  Dimensions of the widget

- `position` (`tuple([number, number])`, default: `null`)

  Position of the widget

- `range` (`tuple([number, number])`, default: `[null,null]`)

  Minimum and maximum values to display on the Y axis

- `stacked` (`bool`, default: `false`)

  Enable the stacked metrics layout

- `title` (`string`, required)

  Widget title

- `view` (`string`, default: `"timeSeries"`)

  Widget view, either timeSeries or singleValue

## Outputs

- `dimensions`

  Widget dimensions

- `position`

  Widget position

- `properties`

  Widget properties

- `type`

  Widget type

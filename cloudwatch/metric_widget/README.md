# cloudwatch/metric_widget

Prepares a metric widget object for `cloudwatch/dashboard`

https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/CloudWatch-Dashboard-Body-Structure.html#CloudWatch-Dashboard-Properties-Widgets-Structure

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |

## Inputs

* `dimensions` (`tuple([number, number])`, default: `[6,6]`)

    Dimensions of the widget

* `hidden_metrics` (`map(object({
    graph_metric_path    = list(string),
    graph_metric_options = any
  }))`, default: `{}`)

    Metrics used in expressions

* `left_annotations` (`list(any)`, default: `[]`)

    Annotations to display on the widget's left Y axis

* `left_metrics` (`map(object({
    graph_metric_path    = list(string),
    graph_metric_options = any
  }))`, default: `{}`)

    Metrics to display on the widget's left Y axis

* `left_range` (`tuple([number, number])`, default: `[null,null]`)

    Minimum and maximum values to display on the left Y axis

* `metric_options` (`map(any)`, default: `{}`)

    Additional metric options, eg. for specifying custom colors or labels

* `position` (`tuple([number, number])`, default: `null`)

    Position of the widget

* `right_annotations` (`list(any)`, default: `[]`)

    Annotations to display on the widget's right Y axis

* `right_metrics` (`map(object({
    graph_metric_path    = list(string),
    graph_metric_options = any
  }))`, default: `{}`)

    Metrics to display on the widget's right Y axis

* `right_range` (`tuple([number, number])`, default: `[null,null]`)

    Minimum and maximum values to display on the right Y axis

* `stacked` (`bool`, default: `false`)

    Enable the stacked metrics layout

* `title` (`string`, required)

    Widget title

* `view` (`string`, default: `"timeSeries"`)

    Widget view, either timeSeries or singleValue



## Outputs

* `height`

    

* `properties`

    

* `type`

    

* `width`

    

* `x`

    

* `y`

    

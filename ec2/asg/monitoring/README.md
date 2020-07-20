# ec2/asg/monitoring

Creates CloudWatch metrics and dashboard widgets for an EC2 Auto-Scaling Group

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |
| `template` | `>= 2.1.2` |

## Inputs

* `name` (`string`, required)

    Auto Scaling Group name

* `widget_name` (`string`, default: `null`)

    Name to use in widget titles, defaults to `name`



## Outputs

* `metrics`

    Cloudwatch metrics, see [metrics.tf](./metrics.tf)

* `widgets`

    Cloudwatch dashboard widgets, see [widgets.tf](./widgets.tf)

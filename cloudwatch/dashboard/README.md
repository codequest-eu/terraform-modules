# cloudwatch/dashboard

Creates a dashboard in cloudwatch with the given widgets.

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |

## Inputs

* `create` (`bool`, default: `true`)

    Should resources be created

* `end` (`string`, default: `null`)

    The end of the time range to use for each widget on the dashboard.
    Has to be an ISO 8601 timestamp, eg. `2020-01-01T00:00:00.000Z`.
    If specified, `start` also has to be a timestamp.


* `name` (`string`, required)

    Name of the dashboard

* `period_override` (`string`, default: `"auto"`)

    Specifies the period for the graphs when the dashboard loads, either `auto` or `inherit`

* `start` (`string`, default: `null`)

    The start of the time range to use for each widget on the dashboard.
    Can be either a relative value, eg. `-PT5M` for last 5 minutes, `-PT7D` for last 7 days,
    or an ISO 8601 timestamp, eg. `2020-01-01T00:00:00.000Z`


* `widgets` (`any`, required)

    Widgets to place on the dashboard



## Outputs

* `arn`

    Dashboard ARN

* `name`

    Dashboard name

* `url`

    Dashboard URL

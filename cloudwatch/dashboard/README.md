# cloudwatch/dashboard

Creates a dashboard in cloudwatch with the given widgets, created with `cloudwatch/widget`.

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |

## Inputs

* `create` (`bool`, default: `true`)

    Should resources be created

* `name` (`string`, required)

    Name of the dashboard

* `widgets` (`any`, required)

    Widgets to place on the dashboard

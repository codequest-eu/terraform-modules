# {{ path }}

<!-- TODO: {{ path }} description -->

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |

## Inputs

* `create` (`bool`, default: `true`)

    Whether any resources should be created

* `tags` (`map(string)`, default: `{}`)

    Tags to add to resources



## Outputs

* `metrics`

    Cloudwatch monitoring metrics

* `widgets`

    Cloudwatch dashboard widgets

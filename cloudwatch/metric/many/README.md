# cloudwatch/metric/many

Same as [cloudwatch/metric](./..) but allows for creating many metrics using a single module

<!-- BEGIN_TF_DOCS -->

## Versions

| Provider  | Requirements |
| --------- | ------------ |
| terraform | `>= 0.12`    |

## Inputs

- `vars` (`any`, default: `[]`)

  List of [cloudwatch/metric](./..) variables

- `vars_map` (`any`, default: `{}`)

  Map of [cloudwatch/metric](./..) variables

## Outputs

- `out`

  List of [cloudwatch/metric](./..) outputs

- `out_map`

  Map of [cloudwatch/metric](./..) outputs

# cloudwatch/annotation

Prepares an annotation structure for widget modules.

<!-- BEGIN_TF_DOCS -->

## Versions

| Provider  | Requirements  |
| --------- | ------------- |
| terraform | (any version) |

## Inputs

- `color` (`string`, default: `null`)

  Annotation color

- `fill` (`string`, default: `"none"`)

  Fill mode, one of (horizontal/vertical): `above`/`after`, `below`/`before`, `none`

- `label` (`string`, default: `null`)

  Annotation label

- `labels` (`tuple([string, string])`, default: `null`)

  Band annotation labels for minimum/start and maximum/end lines

- `time` (`string`, default: `null`)

  Vertical annotation timestamp

- `time_range` (`tuple([string, string])`, default: `null`)

  Vertical band annotation start and end timestamps

- `value` (`number`, default: `null`)

  Horizontal annotation value

- `value_range` (`tuple([number, number])`, default: `null`)

  Horizontal band annotation minimum and maximum values

## Outputs

- `body`

  Annotation structure used by widget modules

- `is_band`

  Whether this is a band annotation

- `is_horizontal`

  Whether this is a horizontal annotation

- `is_vertical`

  Whether this is a vertical annotation

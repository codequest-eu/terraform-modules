# iam/user/set

Creates a set of IAM users with access keys

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.40.0` |

## Inputs

* `create` (`bool`, default: `true`)

    Should resources be created

* `name_prefix` (`string`, default: `""`)

    Kebab-cased prefix which will be added to all user names

* `policy_arns` (`map(map(string))`, required)

    Map of user names to maps of policies that should be attached to them

* `tags` (`map(string)`, default: `{}`)

    Tags to add to resources that support them



## Outputs

* `users`

    Map of created users

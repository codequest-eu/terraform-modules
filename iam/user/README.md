# iam/user

Creates an IAM user along with an access key and attaches the given policies to it.

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

    Kebab-cased user name

* `policy_arns` (`map(string)`, default: `{}`)

    ARNs of policies that should be attached to the user

* `tags` (`map(string)`, default: `{}`)

    Tags to add to resources that support them



## Outputs

* `access_key_id`

    User's access key id

* `arn`

    User ARN

* `secret_access_key`

    User's secret access key

* `ses_smtp_password`

    User's secret access key converted into an SES SMTP password

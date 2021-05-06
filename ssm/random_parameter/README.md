# ssm/random_parameter

Creates an SSM parameter with the given name and populates it with a random string.

<!-- bin/docs -->

## Versions

| Provider | Requirements |
|-|-|
| terraform | `>= 0.12` |
| `aws` | `>= 2.70.0` |
| `random` | `>= 2.1.2` |

## Inputs

* `create` (`bool`, default: `true`)

    Whether any resources should be created

* `description` (`string`, default: `null`)

    Description of the parameter

* `keepers` (`map(any)`, default: `null`)

    Arbitrary map of values that, when changed, will generate a new parameter value. See the [random provider documentation](https://registry.terraform.io/providers/hashicorp/random/latest/docs#resource-keepers) for more information

* `key_id` (`string`, default: `null`)

    The KMS key id or arn for encrypting the parameter value

* `length` (`number`, required)

    Length of the generated value

* `lower` (`bool`, default: `true`)

    Include lowercase alphabet characters in the parameter value

* `min_lower` (`number`, default: `0`)

    Minimum number of lowercase alphabet characters in the parameter value

* `min_numeric` (`number`, default: `0`)

    Minimum number of numeric characters in the parameter value

* `min_special` (`number`, default: `0`)

    Minimum number of special characters in the parameter value

* `min_upper` (`number`, default: `0`)

    Minimum number of uppercase alphabet characters in the parameter value

* `name` (`string`, required)

    Name of the parameter

* `number` (`bool`, default: `true`)

    Include numeric characters in the parameter value

* `special` (`bool`, default: `true`)

    Include special characters in the parameter value.

* `special_characters` (`string`, default: `"!@#$%\u0026*()-_=+[]{}\u003c\u003e:?"`)

    List of special characters to use for string generation.

* `tags` (`map(string)`, default: `{}`)

    Tags to add to resources

* `upper` (`bool`, default: `true`)

    Include uppercase alphabet characters in the parameter value



## Outputs

* `arn`

    Parameter ARN

* `name`

    Parameter name

* `qualified_arn`

    Latest parameter version ARN

* `value`

    Generated parameter value

* `version`

    Parameter version

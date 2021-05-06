# ssm/random_parameter

Creates an SSM parameter with the given name and populates it with a random string.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.12 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.70.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 2.1.2 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.70.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 2.1.2 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ssm_parameter.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [random_password.value](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Whether any resources should be created | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the parameter | `string` | `null` | no |
| <a name="input_keepers"></a> [keepers](#input\_keepers) | Arbitrary map of values that, when changed, will generate a new parameter value. See the [random provider documentation](https://registry.terraform.io/providers/hashicorp/random/latest/docs#resource-keepers) for more information | `map(any)` | `null` | no |
| <a name="input_key_id"></a> [key\_id](#input\_key\_id) | The KMS key id or arn for encrypting the parameter value | `string` | `null` | no |
| <a name="input_length"></a> [length](#input\_length) | Length of the generated value | `number` | n/a | yes |
| <a name="input_lower"></a> [lower](#input\_lower) | Include lowercase alphabet characters in the parameter value | `bool` | `true` | no |
| <a name="input_min_lower"></a> [min\_lower](#input\_min\_lower) | Minimum number of lowercase alphabet characters in the parameter value | `number` | `0` | no |
| <a name="input_min_numeric"></a> [min\_numeric](#input\_min\_numeric) | Minimum number of numeric characters in the parameter value | `number` | `0` | no |
| <a name="input_min_special"></a> [min\_special](#input\_min\_special) | Minimum number of special characters in the parameter value | `number` | `0` | no |
| <a name="input_min_upper"></a> [min\_upper](#input\_min\_upper) | Minimum number of uppercase alphabet characters in the parameter value | `number` | `0` | no |
| <a name="input_name"></a> [name](#input\_name) | Name of the parameter | `string` | n/a | yes |
| <a name="input_number"></a> [number](#input\_number) | Include numeric characters in the parameter value | `bool` | `true` | no |
| <a name="input_special"></a> [special](#input\_special) | Include special characters in the parameter value. | `bool` | `true` | no |
| <a name="input_special_characters"></a> [special\_characters](#input\_special\_characters) | List of special characters to use for string generation. | `string` | `"!@#$%&*()-_=+[]{}<>:?"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to add to resources | `map(string)` | `{}` | no |
| <a name="input_upper"></a> [upper](#input\_upper) | Include uppercase alphabet characters in the parameter value | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | Parameter ARN |
| <a name="output_name"></a> [name](#output\_name) | Parameter name |
| <a name="output_qualified_arn"></a> [qualified\_arn](#output\_qualified\_arn) | Latest parameter version ARN |
| <a name="output_value"></a> [value](#output\_value) | Generated parameter value |
| <a name="output_version"></a> [version](#output\_version) | Parameter version |
<!-- END_TF_DOCS -->

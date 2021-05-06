variable "create" {
  description = "Whether any resources should be created"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to add to resources"
  type        = map(string)
  default     = {}
}

# aws_ssm_parameter inputs:
variable "name" {
  description = "Name of the parameter"
  type        = string
}

variable "description" {
  description = "Description of the parameter"
  type        = string
  default     = null
}

variable "key_id" {
  description = "The KMS key id or arn for encrypting the parameter value"
  type        = string
  default     = null
}

# random_password inputs:
variable "length" {
  description = "Length of the generated value"
  type        = number
}

variable "lower" {
  description = "Include lowercase alphabet characters in the parameter value"
  type        = bool
  default     = true
}

variable "min_lower" {
  description = "Minimum number of lowercase alphabet characters in the parameter value"
  type        = number
  default     = 0
}

variable "upper" {
  description = "Include uppercase alphabet characters in the parameter value"
  type        = bool
  default     = true
}

variable "min_upper" {
  description = "Minimum number of uppercase alphabet characters in the parameter value"
  type        = number
  default     = 0
}

variable "number" {
  description = "Include numeric characters in the parameter value"
  type        = bool
  default     = true
}

variable "min_numeric" {
  description = "Minimum number of numeric characters in the parameter value"
  type        = number
  default     = 0
}

variable "special" {
  description = "Include special characters in the parameter value."
  type        = bool
  default     = true
}

variable "special_characters" {
  description = "List of special characters to use for string generation."
  type        = string
  default     = "!@#$%&*()-_=+[]{}<>:?"
}

variable "min_special" {
  description = "Minimum number of special characters in the parameter value"
  type        = number
  default     = 0
}

variable "keepers" {
  description = "Arbitrary map of values that, when changed, will generate a new parameter value. See the [random provider documentation](https://registry.terraform.io/providers/hashicorp/random/latest/docs#resource-keepers) for more information"
  type        = map(any)
  default     = null
}

terraform {
  required_version = ">= 0.12"

  required_providers {
    random = ">= 2.1.2"
  }
}

variable "variables" {
  type = list(object({
    length = number
  }))
}

resource "random_string" "value" {
  count = length(var.variables)

  length = var.variables[count.index].length
}

output "outputs" {
  value = [for i, v in var.variables : {
    result = random_string.value[i].result
  }]
}

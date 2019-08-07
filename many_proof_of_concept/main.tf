terraform {
  required_version = ">= 0.12"
}

variable "length" {
  type = number
}

module "many" {
  source = "./many"
  variables = [{
    length = var.length
  }]
}

output "result" {
  value = module.many.outputs[0].result
}

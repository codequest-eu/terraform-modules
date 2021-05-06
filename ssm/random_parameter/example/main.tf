provider "aws" {
  region = "eu-west-1" # Ireland
}

module "parameter" {
  source = "./.."

  name   = "/terraform-modules/ssm/random_parameter/example"
  length = 32
}

output "parameter" {
  value = {
    name          = module.parameter.name
    arn           = module.parameter.arn
    version       = module.parameter.version
    qualified_arn = module.parameter.qualified_arn
  }
}

output "parameter_value" {
  sensitive = true
  value     = module.parameter.value
}

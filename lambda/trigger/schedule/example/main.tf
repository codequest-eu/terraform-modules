provider "aws" {
  region = "eu-west-1"
}

locals {
  tags = {
    project     = "terraform-modules"
    environment = "example"
  }
}

module "lambda_package" {
  source = "./../../../../zip"

  files = {
    "index.js" = <<EOF
    async function handler(event) {
      console.log({ event })
    }

    module.exports = { handler }
    EOF
  }
}

module "lambda" {
  source = "./../../.."

  name         = "terraform-modules-example-lambda-trigger-schedule"
  tags         = local.tags
  package_path = module.lambda_package.output_path
}

module "trigger_rate" {
  source = "./.."

  name       = "terraform-modules-example-lambda-trigger-schedule-rate"
  tags       = local.tags
  schedule   = "rate(5 minutes)"
  lambda_arn = module.lambda.qualified_arn
}

output "trigger_rate" {
  value = module.trigger_rate
}

module "trigger_cron" {
  source = "./.."

  name       = "terraform-modules-example-lambda-trigger-schedule-cron"
  tags       = local.tags
  schedule   = "cron(*/5 * * * ? *)"
  lambda_arn = module.lambda.qualified_arn
}

output "trigger_cron" {
  value = module.trigger_cron
}

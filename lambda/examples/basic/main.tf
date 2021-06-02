provider "aws" {
  region = "eu-west-1"

  # https://github.com/hashicorp/terraform-provider-aws/issues/15952
  version = "3.12.0"
}

# Source code defined in terraform --------------------------------------------

module "lambda_inline" {
  source = "./../.."

  name = "terraform-modules-lambda-example-inline"

  files = {
    "index.js" = <<EOF
      async function handler() {
        console.log("Hello Lambda!")
      }

      module.exports = { handler }
    EOF
  }
}

output "lambda_inline" {
  value = module.lambda_inline
}

# Source code in a directory --------------------------------------------------

module "lambda_files_dir" {
  source = "./../.."

  name          = "terraform-modules-lambda-example-files-dir"
  files_dir     = "${path.module}/greeter"
  file_patterns = ["**/*.js"]
}

output "lambda_files_dir" {
  value = module.lambda_files_dir
}

# Environment variables -------------------------------------------------------

module "lambda_environment" {
  source = "./../.."

  name = "terraform-modules-lambda-example-environment"

  files = {
    "index.js" = <<EOF
      async function handler() {
        console.log("Hello", process.env.GREETING_SUBJECT)
      }

      module.exports = { handler }
    EOF
  }

  environment_variables = {
    GREETING_SUBJECT = "Lambda"
  }
}

output "lambda_environment" {
  value = module.lambda_environment
}

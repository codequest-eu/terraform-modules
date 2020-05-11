provider "aws" {
  region = "eu-west-1"
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

# Source code in a directory --------------------------------------------------

module "lambda_files_dir" {
  source = "./../.."

  name          = "terraform-modules-lambda-example-files-dir"
  files_dir     = "${path.module}/greeter"
  file_patterns = ["**/*.js"]
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

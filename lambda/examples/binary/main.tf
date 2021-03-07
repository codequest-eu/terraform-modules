provider "aws" {
  region = "eu-west-1"
}

module "lambda" {
  source = "./../.."

  name = "terraform-modules-lambda-example-binary"

  files_dir     = path.module
  file_patterns = ["index.js", "index.zip"]
}

output "lambda" {
  value = module.lambda
}

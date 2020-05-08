provider "aws" {
  region = "eu-west-1"
}

module "lambda" {
  source = "./.."

  name          = "terraform-modules-lambda-example"
  files_dir     = "${path.module}/src"
  file_patterns = ["**/*.js"]
}

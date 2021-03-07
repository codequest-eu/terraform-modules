provider "aws" {
  region = "eu-west-1" # Ireland

  # https://github.com/hashicorp/terraform-provider-aws/issues/15952
  version = "3.12.0"
}

module "lambda_layer" {
  source = "./.."

  name = "terraform-modules-lambda-layer-example-layer"

  # Remember to run
  #   npm ci --prefix ./src/nodejs
  # before applying, otherwise the layer will be empty
  files_dir     = "${path.module}/src"
  file_patterns = ["nodejs/node_modules/**"]
}

output "lambda_layer" {
  value = module.lambda_layer
}

module "lambda" {
  source = "./../.."

  name = "terraform-modules-lambda-layer-example-lambda"

  files_dir     = "${path.module}/src"
  file_patterns = ["index.js", "package.json"]

  layer_qualified_arns = [module.lambda_layer.qualified_arn]
}

output "lambda" {
  value = module.lambda
}

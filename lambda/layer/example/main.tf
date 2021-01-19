provider "aws" {
  region = "eu-west-1" # Ireland
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

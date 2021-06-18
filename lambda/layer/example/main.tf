provider "aws" {
  region = "eu-west-1" # Ireland
}

module "lambda_layer_package" {
  source = "./../../../zip"

  # Remember to run
  #   npm ci --prefix ./src/nodejs
  # before applying, otherwise the layer will be empty
  directory                  = "${path.module}/src"
  directory_include_patterns = ["nodejs/node_modules/**"]
}

module "lambda_layer" {
  source = "./.."

  name         = "terraform-modules-lambda-layer-example-layer"
  package_path = module.lambda_layer_package.output_path
}

output "lambda_layer" {
  value = module.lambda_layer
}

module "lambda_package" {
  source = "./../../../zip"

  directory                  = "${path.module}/src"
  directory_include_patterns = ["index.js", "package.json"]
}

module "lambda" {
  source = "./../.."

  name                 = "terraform-modules-lambda-layer-example-lambda"
  package_path         = module.lambda_package.output_path
  layer_qualified_arns = [module.lambda_layer.qualified_arn]
}

output "lambda" {
  value = module.lambda
}

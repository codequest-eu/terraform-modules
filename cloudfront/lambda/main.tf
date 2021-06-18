module "package" {
  source = "./../../zip"
  create = var.create

  files = { "index.js" = var.code }
}

module "lambda" {
  source = "./../../lambda"
  create = var.create

  name = var.name
  tags = var.tags

  package_path = module.package.output_path

  handler = var.handler
  runtime = var.runtime

  timeout                = var.timeout
  assume_role_principals = ["edgelambda.amazonaws.com"]
}

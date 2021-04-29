module "lambda" {
  source = "./../../lambda"
  create = var.create

  name = var.name
  tags = var.tags

  files   = { "index.js" = var.code }
  handler = var.handler
  runtime = var.runtime

  timeout                = 30
  assume_role_principals = ["edgelambda.amazonaws.com"]
}

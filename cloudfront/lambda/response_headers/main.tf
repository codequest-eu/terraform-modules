locals {
  global_rule = {
    path         = "**"
    content_type = "**"
    headers      = var.global
  }

  rules = concat([local.global_rule], var.rules)
  rules_json = jsonencode([for rule in local.rules : {
    path : rule.path,
    contentType : rule.content_type,
    headers : rule.headers
  }])
}

module "lambda" {
  source = "./../../../lambda"
  create = var.create

  name = var.name
  tags = var.tags

  files = {
    "index.js"   = file("${path.module}/dist/index.js")
    "rules.json" = local.rules_json,
  }

  handler                = "index.handler"
  runtime                = "nodejs12.x"
  timeout                = 5
  assume_role_principals = ["edgelambda.amazonaws.com"]
}

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

module "package" {
  source = "./../../../zip"
  create = var.create

  files = {
    "index.js"   = file("${path.module}/dist/index.js")
    "rules.json" = local.rules_json,
  }

  output_path = var.package_path
}

module "lambda" {
  source = "./../../../lambda"
  create = var.create

  name = var.name
  tags = var.tags

  package_path = module.package.output_path

  handler                = "index.handler"
  runtime                = "nodejs12.x"
  timeout                = 5
  assume_role_principals = ["edgelambda.amazonaws.com"]
}

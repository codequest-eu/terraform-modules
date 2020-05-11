resource "aws_security_group" "lambda" {
  count = var.create ? 1 : 0

  name   = "${var.name}-lambda"
  vpc_id = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.name}-lambda"
  })
}

module "lambda" {
  source = "./../../../lambda"
  create = var.create

  name = var.name
  tags = var.tags

  files_dir          = "${path.module}/dist"
  handler            = "index.handler"
  security_group_ids = aws_security_group.lambda.*.id
  subnet_ids         = var.subnet_ids

  environment_variables = {
    DATABASE_URL = var.database_url
  }
}

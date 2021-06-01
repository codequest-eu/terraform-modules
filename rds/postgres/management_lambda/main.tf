resource "aws_security_group" "lambda" {
  count = var.create && var.vpc ? 1 : 0

  name   = "${var.name}-lambda"
  vpc_id = var.vpc_id

  tags = merge(var.tags, {
    Name = "${var.name}-lambda"
  })
}

resource "aws_security_group_rule" "lambda_egress_any" {
  count = var.create && var.vpc ? 1 : 0

  security_group_id = aws_security_group.lambda[0].id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

module "lambda" {
  source = "./../../../lambda"
  create = var.create

  name = var.name
  tags = var.tags

  files_dir = "${path.module}/dist"
  handler   = "index.handler"

  security_group_ids = var.create && var.vpc ? aws_security_group.lambda.*.id : null
  subnet_ids         = var.vpc ? var.subnet_ids : null

  environment_variables = {
    DATABASE_URL       = var.database_url
    DATABASE_URL_PARAM = var.database_url_param
  }
}

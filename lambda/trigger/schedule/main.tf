data "aws_arn" "lambda" {
  arn = var.lambda_arn
}

locals {
  # extract name and qualifier from the lambda ARN
  lambda_qualified_name = var.create ? trimprefix(data.aws_arn.lambda.resource, "function:") : ""
  lambda_name           = split(":", local.lambda_qualified_name)[0]
  lambda_qualifier      = try(split(":", local.lambda_qualified_name)[1], null)
}

resource "aws_cloudwatch_event_rule" "rule" {
  count = var.create ? 1 : 0

  name                = var.name
  description         = var.description
  tags                = var.tags
  schedule_expression = var.schedule
}

resource "aws_cloudwatch_event_target" "lambda" {
  count = var.create ? 1 : 0

  target_id = "lambda"
  rule      = aws_cloudwatch_event_rule.rule[0].name
  arn       = var.lambda_arn
}

resource "aws_lambda_permission" "rule_invoke" {
  count = var.create ? 1 : 0

  action        = "lambda:InvokeFunction"
  function_name = local.lambda_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.rule[0].arn
  qualifier     = local.lambda_qualifier
}

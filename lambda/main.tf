locals {
  file_paths = var.create && var.files == null ? setsubtract(
    flatten([for pattern in var.file_patterns : fileset(var.files_dir, pattern)]),
    flatten([for pattern in var.file_exclude_patterns : fileset(var.files_dir, pattern)]),
  ) : toset([])

  files = var.files != null ? var.files : {
    for path in local.file_paths : path => file("${var.files_dir}/${path}")
  }

  files_hash = md5(jsonencode({
    for path, content in local.files : path => md5(content)
  }))

  package_path = "${path.module}/tmp/${local.files_hash}.zip"
}

data "archive_file" "package" {
  count = var.create ? 1 : 0

  type        = "zip"
  output_path = local.package_path

  dynamic "source" {
    for_each = local.files

    content {
      filename = source.key
      content  = source.value
    }
  }
}

data "aws_iam_policy_document" "assume_lambda" {
  count = var.create ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda" {
  count = var.create ? 1 : 0

  name               = var.name
  tags               = var.tags
  assume_role_policy = data.aws_iam_policy_document.assume_lambda[0].json
}

locals {
  in_vpc = var.subnet_ids != null || var.security_group_ids != null
}

resource "aws_iam_role_policy_attachment" "basic" {
  count = var.create ? 1 : 0

  role       = aws_iam_role.lambda[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "vpc" {
  count = var.create && local.in_vpc ? 1 : 0

  role       = aws_iam_role.lambda[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
}

resource "aws_iam_role_policy_attachment" "custom" {
  for_each = var.create ? var.policy_arns : {}

  role       = aws_iam_role.lambda[0].name
  policy_arn = each.value
}

resource "aws_cloudwatch_log_group" "lambda" {
  count = var.create ? 1 : 0

  name = "/aws/lambda/${var.name}"
  tags = var.tags
}

resource "aws_lambda_function" "lambda" {
  count = var.create ? 1 : 0
  depends_on = [
    data.archive_file.package,
    aws_cloudwatch_log_group.lambda,
    aws_iam_role_policy_attachment.basic,
    aws_iam_role_policy_attachment.vpc,
    aws_iam_role_policy_attachment.custom,
  ]

  function_name = var.name
  filename      = local.package_path
  handler       = var.handler
  runtime       = var.runtime
  publish       = true
  timeout       = var.timeout
  memory_size   = var.memory_size
  role          = aws_iam_role.lambda[0].arn

  dynamic "environment" {
    for_each = toset(length(var.environment_variables) > 0 ? ["environment"] : [])

    content {
      variables = var.environment_variables
    }
  }

  vpc_config {
    subnet_ids         = coalesce(var.subnet_ids, [])
    security_group_ids = coalesce(var.security_group_ids, [])
  }

  tags = var.tags
}

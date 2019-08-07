locals {
  hash         = md5(var.code)
  archive_name = "${var.name}.${local.hash}.zip"
  archive_path = "/tmp/${local.archive_name}"
}

data "archive_file" "archive" {
  type        = "zip"
  output_path = local.archive_path

  source {
    content  = var.code
    filename = "index.js"
  }
}

resource "aws_lambda_function" "middleware" {
  filename      = local.archive_path
  function_name = var.name
  role          = var.role_arn
  runtime       = var.runtime
  handler       = var.handler
  publish       = true
  tags          = var.tags
}


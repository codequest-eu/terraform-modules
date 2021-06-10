locals {
  create_package = var.create && (var.files != null || var.files_dir != null)
}

module "package" {
  source = "./../zip"
  create = local.create_package

  files                      = var.files
  directory                  = var.files_dir
  directory_include_patterns = var.file_patterns
  directory_exclude_patterns = var.file_exclude_patterns

  output_path = "${path.module}/tmp/{hash}.zip"
}

data "aws_iam_policy_document" "assume_lambda" {
  count = var.create ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = concat(["lambda.amazonaws.com"], var.assume_role_principals)
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
    aws_cloudwatch_log_group.lambda,
    aws_iam_role_policy_attachment.basic,
    aws_iam_role_policy_attachment.vpc,
    aws_iam_role_policy_attachment.custom,
  ]

  function_name = var.name

  package_type = var.image != null ? "Image" : "Zip"
  image_uri    = var.image

  filename          = local.create_package ? module.package.output_path : var.package_path
  s3_bucket         = var.package_s3 != null ? var.package_s3.bucket : null
  s3_key            = var.package_s3 != null ? var.package_s3.key : null
  s3_object_version = var.package_s3_version

  layers  = var.image == null ? var.layer_qualified_arns : null
  handler = var.image == null ? var.handler : null
  runtime = var.image == null ? var.runtime : null

  publish     = true
  timeout     = var.timeout
  memory_size = var.memory_size
  role        = aws_iam_role.lambda[0].arn

  # AWS provider requires at least one environment variable in the environment block,
  # so just don't create the block at all if var.environment_variables is empty
  dynamic "environment" {
    for_each = toset(length(var.environment_variables) > 0 ? ["environment"] : [])

    content {
      variables = var.environment_variables
    }
  }

  dynamic "vpc_config" {
    for_each = toset(var.subnet_ids != null || var.security_group_ids != null ? ["vpc_config"] : [])

    content {
      subnet_ids         = coalesce(var.subnet_ids, [])
      security_group_ids = coalesce(var.security_group_ids, [])
    }
  }

  tags = var.tags
}

data "aws_region" "current" {}

locals {
  region        = data.aws_region.current.name
  name          = var.create ? aws_lambda_function.lambda[0].function_name : var.name
  arn           = var.create ? aws_lambda_function.lambda[0].arn : ""
  qualified_arn = var.create ? aws_lambda_function.lambda[0].qualified_arn : ""
  invoke_arn    = var.create ? aws_lambda_function.lambda[0].invoke_arn : ""
  version       = var.create ? aws_lambda_function.lambda[0].version : ""
}

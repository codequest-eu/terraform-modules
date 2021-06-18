locals {
  # Config-only aws_lambda_function arguments, for some reason, don't cause
  # a new lambda version to be published, so we're including a hash of them
  # in the lambda source code as a workaround
  # https://github.com/terraform-providers/terraform-provider-aws/pull/11211
  config = {
    role    = var.role_arn
    runtime = var.runtime
    handler = var.handler
  }
  config_hash = md5(jsonencode(local.config))

  code = <<EOF
// lambda config hash: ${local.config_hash}

${var.code}
EOF

  hash                  = md5(local.code)
  archive_path_template = var.archive_path != null ? var.archive_path : "${path.module}/tmp/{hash}.zip"
  archive_path          = replace(local.archive_path_template, "{hash}", local.hash)
}

data "archive_file" "archive" {
  count = var.create ? 1 : 0

  type        = "zip"
  output_path = local.archive_path

  source {
    content  = local.code
    filename = "index.js"
  }
}

resource "aws_lambda_function" "middleware" {
  count      = var.create ? 1 : 0
  depends_on = [data.archive_file.archive[0]]

  filename      = local.archive_path
  function_name = var.name
  publish       = true

  role    = local.config.role
  runtime = local.config.runtime
  handler = local.config.handler

  tags = var.tags
}


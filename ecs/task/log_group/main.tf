locals {
  path = join(
    "/",
    compact(
      ["${var.project}-${var.environment}", var.task, var.container],
    ),
  )

  default_tags = {
    Name        = local.path
    Project     = var.project
    Environment = var.environment
  }

  tags = merge(local.default_tags, var.tags)
}

resource "aws_cloudwatch_log_group" "log" {
  count = var.create ? 1 : 0

  name = local.path
  tags = local.tags
}

data "aws_region" "current" {
  count = var.create ? 1 : 0
}

locals {
  container_log_config = var.create ? {
    "logDriver" = "awslogs"
    "options" = {
      "awslogs-group"         = aws_cloudwatch_log_group.log[0].name
      "awslogs-region"        = data.aws_region.current[0].name
      "awslogs-stream-prefix" = aws_cloudwatch_log_group.log[0].name
    }
  } : {}
}


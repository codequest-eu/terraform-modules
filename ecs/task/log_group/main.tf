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
  name = local.path
  tags = local.tags
}

data "aws_region" "current" {
}

locals {
  container_log_config = <<EOF
{
  "logDriver": "awslogs",
  "options": {
    "awslogs-group": ${jsonencode(aws_cloudwatch_log_group.log.name)},
    "awslogs-region": ${jsonencode(data.aws_region.current.name)},
    "awslogs-stream-prefix": ${jsonencode(aws_cloudwatch_log_group.log.name)}
  }
}
EOF

}


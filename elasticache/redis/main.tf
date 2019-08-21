locals {
  name = "${var.project}-${var.environment}"

  default_tags = {
    Name        = local.name
    Project     = var.project
    Environment = var.environment
  }

  tags = merge(local.default_tags, var.tags)
}

resource "aws_security_group" "cache" {
  count = var.create ? 1 : 0

  name   = "${local.name}-cache"
  vpc_id = var.vpc_id
  tags = merge(
    local.tags,
    {
      "Name" = "${local.name}-cache"
    },
  )
}

resource "aws_security_group_rule" "private" {
  count = var.create ? length(var.security_group_ids) : 0

  security_group_id        = aws_security_group.cache[0].id
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = element(var.security_group_ids, count.index)
}

resource "aws_elasticache_subnet_group" "cache" {
  count = var.create ? 1 : 0

  name       = local.name
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_cluster" "cache" {
  count = var.create ? 1 : 0

  cluster_id = var.id != null ? var.id : local.name

  engine               = "redis"
  engine_version       = var.redis_version
  node_type            = var.instance_type
  num_cache_nodes      = var.instance_count
  parameter_group_name = var.parameter_group_name
  port                 = var.port
  subnet_group_name    = aws_elasticache_subnet_group.cache[0].name
  security_group_ids   = [aws_security_group.cache[0].id]

  tags = local.tags
}


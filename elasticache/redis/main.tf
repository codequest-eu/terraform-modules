locals {
  name = "${var.project}-${var.environment}"

  default_tags = {
    Name        = "${local.name}"
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }

  tags = "${merge(local.default_tags, var.tags)}"
}

resource "aws_security_group" "cache" {
  name   = "${local.name}-cache"
  vpc_id = "${var.vpc_id}"
  tags   = "${merge(local.tags, map("Name", "${local.name}-cache"))}"
}

resource "aws_security_group_rule" "private" {
  count = "${length(var.security_group_ids)}"

  security_group_id        = "${aws_security_group.cache.id}"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${element(var.security_group_ids, count.index)}"
}

resource "aws_elasticache_subnet_group" "cache" {
  name       = "${local.name}"
  subnet_ids = ["${var.subnet_ids}"]
}

resource "aws_elasticache_cluster" "cache" {
  cluster_id = "${var.id != "" ? var.id : local.name}"

  engine               = "redis"
  engine_version       = "${var.redis_version}"
  node_type            = "${var.instance_type}"
  num_cache_nodes      = "${var.instance_count}"
  parameter_group_name = "${var.parameter_group_name}"
  port                 = "${var.port}"
  subnet_group_name    = "${aws_elasticache_subnet_group.cache.name}"
  security_group_ids   = ["${aws_security_group.cache.id}"]

  tags = "${local.tags}"
}

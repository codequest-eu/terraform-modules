locals {
  name     = "${var.project}-${var.environment}"
  db       = "${var.db == "" ? replace(var.project, "-", "_") : var.db}"
  username = "${var.username == "" ? random_string.username.result : var.username}"
  password = "${var.password == "" ? random_string.password.result : var.password}"

  default_tags = {
    Name        = "${local.name}"
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }

  tags = "${merge(local.default_tags, var.tags)}"
}

resource "random_string" "username" {
  count   = "${var.username == "" ? 1 : 0}"
  length  = "${var.username_length}"
  special = false
}

resource "random_string" "password" {
  count   = "${var.password == "" ? 1 : 0}"
  length  = "${var.password_length}"
  special = false
}

resource "aws_db_subnet_group" "db" {
  name       = "${local.name}"
  subnet_ids = ["${var.subnet_ids}"]
  tags       = "${local.tags}"
}

resource "aws_security_group" "db" {
  name   = "${local.name}-db"
  vpc_id = "${var.vpc_id}"
  tags   = "${merge(local.tags, map("Name", "${local.name}-db"))}"
}

resource "aws_security_group_rule" "private" {
  count = "${length(var.security_group_ids)}"

  security_group_id        = "${aws_security_group.db.id}"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = "${element(var.security_group_ids, count.index)}"
}

resource "aws_security_group_rule" "public" {
  count = "${var.public ? 1 : 0}"

  security_group_id = "${aws_security_group.db.id}"
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_db_instance" "db" {
  identifier = "${local.name}"

  engine                    = "postgres"
  engine_version            = "${var.postgres_version}"
  storage_type              = "gp2"
  allocated_storage         = "${var.storage}"
  instance_class            = "${var.instance_type}"
  db_subnet_group_name      = "${aws_db_subnet_group.db.name}"
  multi_az                  = "${var.multi_az}"
  deletion_protection       = "${var.prevent_destroy}"
  final_snapshot_identifier = "${local.name}-final"
  vpc_security_group_ids    = ["${aws_security_group.db.id}"]
  publicly_accessible       = "${var.public}"
  backup_retention_period   = "${var.backup_retention_period}"
  copy_tags_to_snapshot     = true

  port     = "${var.port}"
  name     = "${local.db}"
  username = "${local.username}"
  password = "${local.password}"

  tags = "${local.tags}"
}

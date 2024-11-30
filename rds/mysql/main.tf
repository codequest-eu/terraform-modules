locals {
  name = "${var.project}-${var.environment}"
  db   = var.db != null ? var.db : replace(var.project, "-", "_")

  default_tags = {
    Name        = local.name
    Project     = var.project
    Environment = var.environment
  }

  tags = merge(local.default_tags, var.tags)
}

resource "aws_db_subnet_group" "db" {
  count = var.create ? 1 : 0

  name       = local.name
  subnet_ids = var.subnet_ids
  tags       = local.tags
}

resource "aws_security_group" "db" {
  count = var.create ? 1 : 0

  name   = "${local.name}-db"
  vpc_id = var.vpc_id
  tags = merge(
    local.tags,
    {
      "Name" = "${local.name}-db"
    },
  )
}

resource "aws_security_group_rule" "private" {
  count = var.create ? length(var.security_group_ids) : 0

  security_group_id        = aws_security_group.db[0].id
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = element(var.security_group_ids, count.index)
}

resource "aws_security_group_rule" "public" {
  count = var.create && var.public ? 1 : 0

  security_group_id = aws_security_group.db[0].id
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_db_instance" "db" {
  count = var.create ? 1 : 0

  identifier = local.name

  engine                     = "mysql"
  engine_version             = var.mysql_version
  storage_type               = "gp2"
  allocated_storage          = var.storage
  instance_class             = var.instance_type
  db_subnet_group_name       = aws_db_subnet_group.db[0].name
  multi_az                   = var.multi_az
  deletion_protection        = var.prevent_destroy
  final_snapshot_identifier  = "${local.name}-final"
  vpc_security_group_ids     = [aws_security_group.db[0].id]
  publicly_accessible        = var.public
  backup_retention_period    = var.backup_retention_period
  copy_tags_to_snapshot      = true
  auto_minor_version_upgrade = false

  port     = var.port
  name     = local.db
  username = var.username
  password = var.password

  tags = local.tags
}

locals {
  host   = var.create ? aws_db_instance.db[0].address : ""
  port   = var.create ? aws_db_instance.db[0].port : ""
  db_url = var.create ? "mysql://${var.username}:${var.password}@${local.host}:${local.port}/${local.db}" : ""
}

module "management_lambda" {
  source = "./management_lambda"
  create = var.create && var.create_management_lambda

  name         = "${local.name}-db-management"
  tags         = var.tags
  database_url = local.db_url
  vpc_id       = var.vpc_id
  subnet_ids   = var.subnet_ids
}

resource "aws_security_group_rule" "management_lambda" {
  count = var.create && var.create_management_lambda ? 1 : 0

  security_group_id        = aws_security_group.db[0].id
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = module.management_lambda.security_group_id
}

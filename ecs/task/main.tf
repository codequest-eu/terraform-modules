locals {
  family    = "${var.project}-${var.environment}-${var.task}"
  container = var.container != null ? var.container : var.task

  image_tag = var.image_tag != null ? var.image_tag : data.aws_ecs_container_definition.current[0].image_digest
  image     = var.image != null ? var.image : "${var.image_name}:${local.image_tag}"
}

module "container_log" {
  source = "./log_group"
  create = var.create

  project     = var.project
  environment = var.environment
  task        = var.task
  container   = var.container
  tags        = var.tags
}

data "aws_ecs_container_definition" "current" {
  count           = var.create && var.image_tag == null ? 1 : 0
  task_definition = local.family
  container_name  = local.container
}

module "container" {
  source = "./container_definition"
  create = var.create

  name                  = local.container
  image                 = local.image
  memory_hard_limit     = var.memory_hard_limit
  memory_soft_limit     = var.memory_soft_limit
  ports                 = var.ports
  cpu                   = var.cpu
  essential             = var.essential
  entry_point           = var.entry_point
  command               = var.command
  working_directory     = var.working_directory
  environment_variables = var.environment_variables
  log_config            = module.container_log.container_config
}

resource "aws_ecs_task_definition" "task" {
  count = var.create ? 1 : 0

  family                = local.family
  container_definitions = jsonencode([module.container.definition])
  task_role_arn         = var.role_arn
}


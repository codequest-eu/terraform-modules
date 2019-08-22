locals {
  family    = "${var.project}-${var.environment}-${var.task}"
  container = "${var.container == "" ? var.task : var.container}"

  image_tag = "${var.image_tag == "" ? join("", data.aws_ecs_container_definition.current.*.image_digest) : var.image_tag}"
  image     = "${var.image == "" ? "${var.image_name}:${local.image_tag}" : var.image}"
}

module "container_log" {
  source = "./log_group"

  project     = "${var.project}"
  environment = "${var.environment}"
  task        = "${var.task}"
  container   = "${var.container}"
  tags        = "${var.tags}"
}

data "aws_ecs_container_definition" "current" {
  count           = "${var.image_tag == "" ? 1 : 0}"
  task_definition = "${local.family}"
  container_name  = "${local.container}"
}

module "container" {
  source = "./container_definition"

  name                  = "${local.container}"
  image                 = "${local.image}"
  memory_hard_limit     = "${var.memory_hard_limit}"
  memory_soft_limit     = "${var.memory_soft_limit}"
  ports                 = "${var.ports}"
  cpu                   = "${var.cpu}"
  essential             = "${var.essential}"
  entry_point           = "${var.entry_point}"
  command               = "${var.command}"
  working_directory     = "${var.working_directory}"
  environment_variables = "${var.environment_variables}"
  log_config            = "${module.container_log.container_config}"
}

resource "aws_ecs_task_definition" "task" {
  family                = "${local.family}"
  container_definitions = "[${module.container.definition}]"
  task_role_arn         = "${var.role_arn}"
}

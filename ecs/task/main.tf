module "container_log" {
  source = "./log_group"

  project     = "${var.project}"
  environment = "${var.environment}"
  task        = "${var.task}"
  container   = "${var.container}"
  tags        = "${var.tags}"
}

module "container" {
  source = "./container_definition"

  name                  = "${var.container == "" ? var.task : var.container}"
  image                 = "${var.image}"
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
  family                = "${var.project}-${var.environment}-${var.task}"
  container_definitions = "[${module.container.definition}]"
  task_role_arn         = "${var.role_arn}"
}

data "aws_ecs_task_definition" "latest" {
  task_definition = "${aws_ecs_task_definition.task.family}"
}

locals {
  latest_arn = "${replace(aws_ecs_task_definition.task.arn, "/^(.*):\\d+$/", "$1:${data.aws_ecs_task_definition.latest.revision}")}"
}

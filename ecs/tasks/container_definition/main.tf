locals {
  log_region = "${var.log_region == "" ? data.aws_region.current.name : var.log_region}"

  definition = <<EOF
{
  "name": ${jsonencode(var.name)},
  "image": ${jsonencode(var.image)},
  "memory": ${var.memory_hard_limit},
  "memoryReservation": ${var.memory_soft_limit},
  "portMappings": [${join(", ", data.template_file.port_mapping.*.rendered)}],
  "cpu": ${var.cpu},
  "essential": ${var.essential ? "true" : "false"},
  "entryPoint": ${var.entry_point},
  "command": ${var.command},
  "workingDirectory": ${var.working_directory == "" ? "null" : jsonencode(var.working_directory)},
  "environment": [${join(", ", data.template_file.environment_variable.*.rendered)}],
  "logConfiguration": {
    "logDriver": "awslogs",
    "options": {
      "awslogs-group": ${jsonencode(var.log_group)},
      "awslogs-region": ${jsonencode(local.log_region)},
      "awslogs-stream-prefix": ${jsonencode(var.log_prefix)}
    }
  }
}
EOF
}

data "aws_region" "current" {}

data "template_file" "port_mapping" {
  count = "${length(var.ports)}"

  template = <<EOF
{
    "containerPort": ${element(var.ports, count.index)},
    "protocol": "tcp"
  }
EOF
}

data "template_file" "environment_variable" {
  count = "${length(var.environment)}"

  template = <<EOF
{
    "name": ${jsonencode(element(keys(var.environment), count.index))},
    "value": ${jsonencode(element(values(var.environment), count.index))}
  }
EOF
}

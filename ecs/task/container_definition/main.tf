locals {
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
  "logConfiguration": ${var.log_config}
}
EOF

}

data "aws_region" "current" {
}

data "template_file" "port_mapping" {
  count = length(var.ports)

  template = <<EOF
{
    "containerPort": ${element(var.ports, count.index)},
    "protocol": "tcp"
  }
EOF

}

data "template_file" "environment_variable" {
  count = length(var.environment_variables)

  template = <<EOF
{
    "name": ${jsonencode(element(keys(var.environment_variables), count.index))},
    "value": ${jsonencode(element(values(var.environment_variables), count.index))}
  }
EOF

}


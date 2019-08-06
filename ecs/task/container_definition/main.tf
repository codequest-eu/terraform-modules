locals {
  definition = {
    name              = var.name
    image             = var.image
    memory            = var.memory_hard_limit
    memoryReservation = var.memory_soft_limit
    portMappings = [for port in var.ports : {
      containerPort = port
      hostPort      = 0
      protocol      = "tcp"
    }]
    cpu              = var.cpu
    essential        = var.essential
    entryPoint       = var.entry_point
    command          = var.command
    workingDirectory = var.working_directory
    environment = [for name, value in var.environment_variables : {
      name  = name
      value = value
    }]
    logConfiguration = var.log_config
    mountPoints      = []
    volumesFrom      = []
  }
}

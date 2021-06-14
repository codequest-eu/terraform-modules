locals {
  inject_environment_parameters_hash = (
    var.enable_environment_parameters_hash &&
    length(var.environment_parameters) > 0
  )
  environment_parameters_hash = (
    local.inject_environment_parameters_hash ?
    md5(jsonencode({
      for name, parameter in var.environment_parameters :
      name => "${parameter.arn}:${parameter.version}"
    })) :
    null
  )

  definition = {
    name      = var.name
    essential = var.essential

    cpu               = var.cpu
    memory            = var.memory_hard_limit
    memoryReservation = var.memory_soft_limit

    image            = var.image
    entryPoint       = var.entry_point
    command          = var.command
    workingDirectory = var.working_directory

    environment = concat(
      [for name, value in var.environment_variables : {
        name  = name
        value = value
      }],
      local.inject_environment_parameters_hash ? [{
        name  = "SSM_PARAMETERS_HASH",
        value = local.environment_parameters_hash
      }] : []
    )
    secrets = [for name, parameter in var.environment_parameters : {
      name      = name,
      valueFrom = parameter.arn
    }]
    mountPoints = []
    volumesFrom = []

    portMappings = [for port in sort(var.ports) : {
      containerPort = tonumber(port)
      protocol      = "tcp"
    }]

    logConfiguration = var.log_config
  }
}

locals {
  metrics = {
    cpu_utilization    = module.metrics_cpu.out_map.utilization
    cpu_reservation    = module.metrics_cpu.out_map.reservation
    memory_utilization = module.metrics_memory.out_map.utilization
    memory_reservation = module.metrics_memory.out_map.reservation

    instances = module.metrics_count.out_map.instance
    services  = module.metrics_count.out_map.service
    tasks     = module.metrics_count.out_map.task
  }
}

module "cloudwatch_consts" {
  source = "./../cloudwatch/consts"
}

locals {
  colors = module.cloudwatch_consts.colors
}

locals {
  cluster_dimensions = {
    ClusterName = var.create ? aws_ecs_cluster.cluster[0].name : ""
  }

  metrics_utilization = {
    reservation = { name = "Reservation", color = local.colors.grey }
    utilization = { name = "Utilization", color = local.colors.orange }
  }
}

module "metrics_cpu" {
  source = "./../cloudwatch/metric/many"

  vars_map = { for k, v in local.metrics_utilization : k => {
    namespace  = "AWS/ECS"
    dimensions = local.cluster_dimensions
    name       = "CPU${v.name}"
    label      = "CPU ${lower(v.name)}"
    color      = v.color
    stat       = "Average"
    period     = 60
  } }
}

module "metrics_memory" {
  source = "./../cloudwatch/metric/many"

  vars_map = { for k, v in local.metrics_utilization : k => {
    namespace  = "AWS/ECS"
    dimensions = local.cluster_dimensions
    name       = "Memory${v.name}"
    label      = "Memory ${lower(v.name)}"
    color      = v.color
    stat       = "Average"
    period     = 60
  } }
}

locals {
  metrics_count = {
    instance = { name = "ContainerInstance", label = "Instances" }
    service  = { name = "Service", label = "Services" }
    task     = { name = "Task", label = "Tasks" }
  }
}

module "metrics_count" {
  source = "./../cloudwatch/metric/many"

  vars_map = { for k, v in local.metrics_count : k => {
    namespace  = "ECS/ContainerInsights"
    dimensions = local.cluster_dimensions
    name       = "${v.name}Count"
    label      = v.label
    stat       = "Average"
    period     = 60
  } }
}

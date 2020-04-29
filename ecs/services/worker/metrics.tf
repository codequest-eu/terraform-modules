locals {
  metrics = {
    desired_tasks              = module.metrics_tasks.out_map.desired
    pending_tasks              = module.metrics_tasks.out_map.pending
    running_tasks              = module.metrics_tasks.out_map.running
    average_cpu_reservation    = module.metric_average_cpu_reservation
    min_cpu_utilization        = module.metrics_cpu_utilization.out_map.min
    average_cpu_utilization    = module.metrics_cpu_utilization.out_map.average
    max_cpu_utilization        = module.metrics_cpu_utilization.out_map.max
    average_memory_reservation = module.metric_average_memory_reservation
    min_memory_utilization     = module.metrics_memory_utilization.out_map.min
    average_memory_utilization = module.metrics_memory_utilization.out_map.average
    max_memory_utilization     = module.metrics_memory_utilization.out_map.max
  }
}

module "cloudwatch_consts" {
  source = "./../../../cloudwatch/consts"
}

locals {
  colors = module.cloudwatch_consts.colors
}

locals {
  metrics_tasks_variants = {
    desired = { state = "Desired", color = local.colors.grey }
    pending = { state = "Pending", color = local.colors.orange }
    running = { state = "Running", color = local.colors.green }
  }
}

module "metrics_tasks" {
  source = "./../../../cloudwatch/metric/many"

  vars_map = { for k, variant in local.metrics_tasks_variants : k => {
    namespace = "ECS/ContainerInsights"
    name      = "${variant.state}TaskCount"
    label     = "${variant.state} task count"
    color     = variant.color
    stat      = "Average"
    period    = 60

    dimensions = {
      ServiceName = var.name
      ClusterName = local.cluster_name
    }
  } }
}

module "metric_average_cpu_reservation" {
  source = "./../../../cloudwatch/metric"

  namespace = "ECS/ContainerInsights"
  name      = "CpuReserved"
  label     = "Average CPU reserved"
  color     = local.colors.grey
  stat      = "Average"
  period    = 60

  dimensions = {
    ServiceName = var.name
    ClusterName = local.cluster_name
  }
}

locals {
  metrics_utilization_variants = {
    min     = { stat = "Minimum", color = local.colors.light_orange }
    average = { stat = "Average", color = local.colors.orange }
    max     = { stat = "Maximum", color = local.colors.red }
  }
}

module "metrics_cpu_utilization" {
  source = "./../../../cloudwatch/metric/many"

  vars_map = { for k, variant in local.metrics_utilization_variants : k => {
    namespace = "ECS/ContainerInsights"
    name      = "CpuUtilized"
    label     = "${variant.stat} CPU utilized"
    color     = variant.color
    stat      = variant.stat
    period    = 60

    dimensions = {
      ServiceName = var.name
      ClusterName = local.cluster_name
    }
  } }
}

module "metric_average_memory_reservation" {
  source = "./../../../cloudwatch/metric"

  namespace = "ECS/ContainerInsights"
  name      = "MemoryReserved"
  label     = "Average memory reserved"
  color     = local.colors.grey
  stat      = "Average"
  period    = 60

  dimensions = {
    ServiceName = var.name
    ClusterName = local.cluster_name
  }
}

module "metrics_memory_utilization" {
  source = "./../../../cloudwatch/metric/many"

  vars_map = { for k, variant in local.metrics_utilization_variants : k => {
    namespace = "ECS/ContainerInsights"
    name      = "MemoryUtilized"
    label     = "${variant.stat} memory utilized"
    color     = variant.color
    stat      = variant.stat
    period    = 60

    dimensions = {
      ServiceName = var.name
      ClusterName = local.cluster_name
    }
  } }
}

locals {
  metrics = {
    desired_tasks              = module.metric_desired_tasks
    pending_tasks              = module.metric_pending_tasks
    running_tasks              = module.metric_running_tasks
    average_cpu_reservation    = module.metric_average_cpu_reservation
    min_cpu_utilization        = module.metric_min_cpu_utilization
    average_cpu_utilization    = module.metric_average_cpu_utilization
    max_cpu_utilization        = module.metric_max_cpu_utilization
    average_memory_reservation = module.metric_average_memory_reservation
    min_memory_utilization     = module.metric_min_memory_utilization
    average_memory_utilization = module.metric_average_memory_utilization
    max_memory_utilization     = module.metric_max_memory_utilization
  }
}

module "cloudwatch_consts" {
  source = "./../../../cloudwatch/consts"
}

locals {
  colors = module.cloudwatch_consts.colors
}

module "metric_desired_tasks" {
  source = "./../../../cloudwatch/metric"

  namespace = "ECS/ContainerInsights"
  name      = "DesiredTaskCount"
  label     = "Desired task count"
  color     = local.colors.grey
  stat      = "Average"
  period    = 60

  dimensions = {
    ServiceName = var.name
    ClusterName = local.cluster_name
  }
}

module "metric_pending_tasks" {
  source = "./../../../cloudwatch/metric"

  namespace = "ECS/ContainerInsights"
  name      = "PendingTaskCount"
  label     = "Pending task count"
  color     = local.colors.orange
  stat      = "Average"
  period    = 60

  dimensions = {
    ServiceName = var.name
    ClusterName = local.cluster_name
  }
}

module "metric_running_tasks" {
  source = "./../../../cloudwatch/metric"

  namespace = "ECS/ContainerInsights"
  name      = "RunningTaskCount"
  label     = "Running task count"
  color     = local.colors.green
  stat      = "Average"
  period    = 60

  dimensions = {
    ServiceName = var.name
    ClusterName = local.cluster_name
  }
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

module "metric_min_cpu_utilization" {
  source = "./../../../cloudwatch/metric"

  namespace = "ECS/ContainerInsights"
  name      = "CpuUtilized"
  label     = "Minimum CPU utilized"
  color     = local.colors.light_orange
  stat      = "Minimum"
  period    = 60

  dimensions = {
    ServiceName = var.name
    ClusterName = local.cluster_name
  }
}

module "metric_average_cpu_utilization" {
  source = "./../../../cloudwatch/metric"

  namespace = "ECS/ContainerInsights"
  name      = "CpuUtilized"
  label     = "Average CPU utilized"
  color     = local.colors.orange
  stat      = "Average"
  period    = 60

  dimensions = {
    ServiceName = var.name
    ClusterName = local.cluster_name
  }
}

module "metric_max_cpu_utilization" {
  source = "./../../../cloudwatch/metric"

  namespace = "ECS/ContainerInsights"
  name      = "CpuUtilized"
  label     = "Maximum CPU utilized"
  color     = local.colors.red
  stat      = "Maximum"
  period    = 60

  dimensions = {
    ServiceName = var.name
    ClusterName = local.cluster_name
  }
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

module "metric_min_memory_utilization" {
  source = "./../../../cloudwatch/metric"

  namespace = "ECS/ContainerInsights"
  name      = "MemoryUtilized"
  label     = "Minimum memory utilized"
  color     = local.colors.light_orange
  stat      = "Minimum"
  period    = 60

  dimensions = {
    ServiceName = var.name
    ClusterName = local.cluster_name
  }
}

module "metric_average_memory_utilization" {
  source = "./../../../cloudwatch/metric"

  namespace = "ECS/ContainerInsights"
  name      = "MemoryUtilized"
  label     = "Average memory utilized"
  color     = local.colors.orange
  stat      = "Average"
  period    = 60

  dimensions = {
    ServiceName = var.name
    ClusterName = local.cluster_name
  }
}

module "metric_max_memory_utilization" {
  source = "./../../../cloudwatch/metric"

  namespace = "ECS/ContainerInsights"
  name      = "MemoryUtilized"
  label     = "Maximum memory utilized"
  color     = local.colors.red
  stat      = "Maximum"
  period    = 60

  dimensions = {
    ServiceName = var.name
    ClusterName = local.cluster_name
  }
}

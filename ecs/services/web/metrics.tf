locals {
  metrics = {
    requests                       = module.metric_requests
    status_2xx_responses           = module.metric_2xx_responses
    status_2xx_response_percentage = module.metric_2xx_response_percentage
    status_3xx_responses           = module.metric_3xx_responses
    status_3xx_response_percentage = module.metric_3xx_response_percentage
    status_4xx_responses           = module.metric_4xx_responses
    status_4xx_response_percentage = module.metric_4xx_response_percentage
    status_5xx_responses           = module.metric_5xx_responses
    status_5xx_response_percentage = module.metric_5xx_response_percentage
    connection_errors              = module.metric_connection_errors
    connection_error_percentage    = module.metric_connection_error_percentage
    average_response_time          = module.metric_average_response_time
    p50_response_time              = module.metric_p50_response_time
    p90_response_time              = module.metric_p90_response_time
    p95_response_time              = module.metric_p95_response_time
    p99_response_time              = module.metric_p99_response_time
    max_response_time              = module.metric_max_response_time
    desired_tasks                  = module.metric_desired_tasks
    pending_tasks                  = module.metric_pending_tasks
    running_tasks                  = module.metric_running_tasks
    average_cpu_reservation        = module.metric_average_cpu_reservation
    min_cpu_utilization            = module.metric_min_cpu_utilization
    average_cpu_utilization        = module.metric_average_cpu_utilization
    max_cpu_utilization            = module.metric_max_cpu_utilization
    average_memory_reservation     = module.metric_average_memory_reservation
    min_memory_utilization         = module.metric_min_memory_utilization
    average_memory_utilization     = module.metric_average_memory_utilization
    max_memory_utilization         = module.metric_max_memory_utilization
  }
}

data "aws_lb_listener" "listener" {
  count = var.create ? 1 : 0

  arn = var.listener_arn
}

data "aws_lb" "lb" {
  count = var.create ? 1 : 0

  arn = data.aws_lb_listener.listener[0].load_balancer_arn
}

module "cloudwatch_consts" {
  source = "./../../../cloudwatch/consts"
}

locals {
  colors = module.cloudwatch_consts.colors
}

module "metric_requests" {
  source = "./../../../cloudwatch/metric"

  namespace = "AWS/ApplicationELB"
  name      = "RequestCount"
  label     = "Responses"
  stat      = "Sum"
  period    = 60

  dimensions = {
    LoadBalancer = var.create ? data.aws_lb.lb[0].arn_suffix : ""
    TargetGroup  = var.create ? aws_lb_target_group.service[0].arn_suffix : ""
  }
}

module "metric_2xx_responses" {
  source = "./../../../cloudwatch/metric"

  namespace = "AWS/ApplicationELB"
  name      = "HTTPCode_Target_2XX_Count"
  label     = "2xx responses"
  color     = local.colors.green
  stat      = "Sum"
  period    = 60

  dimensions = {
    LoadBalancer = var.create ? data.aws_lb.lb[0].arn_suffix : ""
    TargetGroup  = var.create ? aws_lb_target_group.service[0].arn_suffix : ""
  }
}

module "metric_2xx_response_percentage" {
  source = "./../../../cloudwatch/metric_expression"

  expression = "IF(${module.metric_requests.id} == 0, 0, FILL(${module.metric_2xx_responses.id}, 0) / ${module.metric_requests.id} * 100)"
  label      = "2xx response ratio"
  color      = module.metric_2xx_responses.color
}

module "metric_3xx_responses" {
  source = "./../../../cloudwatch/metric"

  namespace = "AWS/ApplicationELB"
  name      = "HTTPCode_Target_3XX_Count"
  label     = "3xx responses"
  color     = local.colors.blue
  stat      = "Sum"
  period    = 60

  dimensions = {
    LoadBalancer = var.create ? data.aws_lb.lb[0].arn_suffix : ""
    TargetGroup  = var.create ? aws_lb_target_group.service[0].arn_suffix : ""
  }
}

module "metric_3xx_response_percentage" {
  source = "./../../../cloudwatch/metric_expression"

  expression = "IF(${module.metric_requests.id} == 0, 0, FILL(${module.metric_3xx_responses.id}, 0) / ${module.metric_requests.id} * 100)"
  label      = "3xx response ratio"
  color      = module.metric_3xx_responses.color
}

module "metric_4xx_responses" {
  source = "./../../../cloudwatch/metric"

  namespace = "AWS/ApplicationELB"
  name      = "HTTPCode_Target_4XX_Count"
  label     = "4xx responses"
  color     = local.colors.orange
  stat      = "Sum"
  period    = 60

  dimensions = {
    LoadBalancer = var.create ? data.aws_lb.lb[0].arn_suffix : ""
    TargetGroup  = var.create ? aws_lb_target_group.service[0].arn_suffix : ""
  }
}

module "metric_4xx_response_percentage" {
  source = "./../../../cloudwatch/metric_expression"

  expression = "IF(${module.metric_requests.id} == 0, 0, FILL(${module.metric_4xx_responses.id}, 0) / ${module.metric_requests.id} * 100)"
  label      = "4xx response ratio"
  color      = module.metric_4xx_responses.color
}

module "metric_5xx_responses" {
  source = "./../../../cloudwatch/metric"

  namespace = "AWS/ApplicationELB"
  name      = "HTTPCode_Target_5XX_Count"
  label     = "5xx responses"
  color     = local.colors.red
  stat      = "Sum"
  period    = 60

  dimensions = {
    LoadBalancer = var.create ? data.aws_lb.lb[0].arn_suffix : ""
    TargetGroup  = var.create ? aws_lb_target_group.service[0].arn_suffix : ""
  }
}

module "metric_5xx_response_percentage" {
  source = "./../../../cloudwatch/metric_expression"

  expression = "IF(${module.metric_requests.id} == 0, 0, FILL(${module.metric_5xx_responses.id}, 0) / ${module.metric_requests.id} * 100)"
  label      = "5xx response ratio"
  color      = module.metric_5xx_responses.color
}

module "metric_connection_errors" {
  source = "./../../../cloudwatch/metric"

  namespace = "AWS/ApplicationELB"
  name      = "TargetConnectionErrorCount"
  label     = "Connection errors"
  color     = local.colors.purple
  stat      = "Sum"
  period    = 60

  dimensions = {
    LoadBalancer = var.create ? data.aws_lb.lb[0].arn_suffix : ""
    TargetGroup  = var.create ? aws_lb_target_group.service[0].arn_suffix : ""
  }
}

module "metric_connection_error_percentage" {
  source = "./../../../cloudwatch/metric_expression"

  expression = "IF(${module.metric_requests.id} == 0, 0, FILL(${module.metric_connection_errors.id}, 0) / ${module.metric_requests.id} * 100)"
  label      = "Connection errors ratio"
  color      = module.metric_connection_errors.color
}

module "metric_average_response_time" {
  source = "./../../../cloudwatch/metric"

  namespace = "AWS/ApplicationELB"
  name      = "TargetResponseTime"
  label     = "Average response time"
  color     = local.colors.red
  stat      = "Average"
  period    = 60

  dimensions = {
    LoadBalancer = var.create ? data.aws_lb.lb[0].arn_suffix : ""
    TargetGroup  = var.create ? aws_lb_target_group.service[0].arn_suffix : ""
  }
}

module "metric_p50_response_time" {
  source = "./../../../cloudwatch/metric"

  namespace = "AWS/ApplicationELB"
  name      = "TargetResponseTime"
  label     = "p50 response time"
  color     = local.colors.red
  stat      = "p50"
  period    = 60

  dimensions = {
    LoadBalancer = var.create ? data.aws_lb.lb[0].arn_suffix : ""
    TargetGroup  = var.create ? aws_lb_target_group.service[0].arn_suffix : ""
  }
}

module "metric_p90_response_time" {
  source = "./../../../cloudwatch/metric"

  namespace = "AWS/ApplicationELB"
  name      = "TargetResponseTime"
  label     = "p90 response time"
  stat      = "p90"
  period    = 60

  dimensions = {
    LoadBalancer = var.create ? data.aws_lb.lb[0].arn_suffix : ""
    TargetGroup  = var.create ? aws_lb_target_group.service[0].arn_suffix : ""
  }
}

module "metric_p95_response_time" {
  source = "./../../../cloudwatch/metric"

  namespace = "AWS/ApplicationELB"
  name      = "TargetResponseTime"
  label     = "p95 response time"
  stat      = "p95"
  period    = 60

  dimensions = {
    LoadBalancer = var.create ? data.aws_lb.lb[0].arn_suffix : ""
    TargetGroup  = var.create ? aws_lb_target_group.service[0].arn_suffix : ""
  }
}

module "metric_p99_response_time" {
  source = "./../../../cloudwatch/metric"

  namespace = "AWS/ApplicationELB"
  name      = "TargetResponseTime"
  label     = "p99 response time"
  stat      = "p99"
  period    = 60

  dimensions = {
    LoadBalancer = var.create ? data.aws_lb.lb[0].arn_suffix : ""
    TargetGroup  = var.create ? aws_lb_target_group.service[0].arn_suffix : ""
  }
}

module "metric_max_response_time" {
  source = "./../../../cloudwatch/metric"

  namespace = "AWS/ApplicationELB"
  name      = "TargetResponseTime"
  label     = "Maximum response time"
  stat      = "Maximum"
  period    = 60

  dimensions = {
    LoadBalancer = var.create ? data.aws_lb.lb[0].arn_suffix : ""
    TargetGroup  = var.create ? aws_lb_target_group.service[0].arn_suffix : ""
  }
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

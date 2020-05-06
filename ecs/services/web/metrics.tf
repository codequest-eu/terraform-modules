locals {
  metrics = {
    requests                       = module.metric_requests
    status_2xx_responses           = module.metrics_response_statuses.out_map["2xx"]
    status_2xx_response_percentage = module.metrics_response_status_percentages.out_map["2xx"]
    status_3xx_responses           = module.metrics_response_statuses.out_map["3xx"]
    status_3xx_response_percentage = module.metrics_response_status_percentages.out_map["3xx"]
    status_4xx_responses           = module.metrics_response_statuses.out_map["4xx"]
    status_4xx_response_percentage = module.metrics_response_status_percentages.out_map["4xx"]
    status_5xx_responses           = module.metrics_response_statuses.out_map["5xx"]
    status_5xx_response_percentage = module.metrics_response_status_percentages.out_map["5xx"]
    connection_errors              = module.metric_connection_errors
    connection_error_percentage    = module.metric_connection_error_percentage
    average_response_time          = module.metrics_response_time.out_map.average
    p50_response_time              = module.metrics_response_time.out_map.p50
    p90_response_time              = module.metrics_response_time.out_map.p90
    p95_response_time              = module.metrics_response_time.out_map.p95
    p99_response_time              = module.metrics_response_time.out_map.p99
    max_response_time              = module.metrics_response_time.out_map.max
    desired_tasks                  = module.metrics_tasks.out_map.desired
    pending_tasks                  = module.metrics_tasks.out_map.pending
    running_tasks                  = module.metrics_tasks.out_map.running
    healthy_tasks                  = module.metric_healthy_tasks
    average_cpu_reservation        = module.metric_average_cpu_reservation
    min_cpu_utilization            = module.metrics_cpu_utilization.out_map.min
    average_cpu_utilization        = module.metrics_cpu_utilization.out_map.average
    max_cpu_utilization            = module.metrics_cpu_utilization.out_map.max
    average_memory_reservation     = module.metric_average_memory_reservation
    min_memory_utilization         = module.metrics_memory_utilization.out_map.min
    average_memory_utilization     = module.metrics_memory_utilization.out_map.average
    max_memory_utilization         = module.metrics_memory_utilization.out_map.max
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

locals {
  metrics_response_statuses = {
    "2xx" = { color = local.colors.green }
    "3xx" = { color = local.colors.blue }
    "4xx" = { color = local.colors.orange }
    "5xx" = { color = local.colors.red }
  }
}

module "metrics_response_statuses" {
  source = "./../../../cloudwatch/metric/many"

  vars_map = { for status, variant in local.metrics_response_statuses : status => {
    namespace = "AWS/ApplicationELB"
    name      = "HTTPCode_Target_${upper(status)}_Count"
    label     = "${status} responses"
    color     = variant.color
    stat      = "Sum"
    period    = 60

    dimensions = {
      LoadBalancer = var.create ? data.aws_lb.lb[0].arn_suffix : ""
      TargetGroup  = var.create ? aws_lb_target_group.service[0].arn_suffix : ""
    }
  } }
}

module "metrics_response_status_percentages" {
  source = "./../../../cloudwatch/metric_expression/many"

  vars_map = { for status, variant in local.metrics_response_statuses : status => {
    expression = "IF(${module.metric_requests.id} == 0, 0, FILL(${module.metrics_response_statuses.out_map[status].id}, 0) / ${module.metric_requests.id} * 100)"
    label      = "${status} responses"
    color      = variant.color
  } }
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
  label      = "Connection errors"
  color      = module.metric_connection_errors.color
}

locals {
  metrics_response_time_variants = {
    average = { stat = "Average", color = local.colors.red }
    p50     = { stat = "p50", color = local.colors.red }
    p90     = { stat = "p90", color = local.colors.orange }
    p95     = { stat = "p95", color = local.colors.orange }
    p99     = { stat = "p99", color = local.colors.light_red }
    max     = { stat = "Maximum", color = local.colors.light_orange }
  }
}

module "metrics_response_time" {
  source = "./../../../cloudwatch/metric/many"

  vars_map = { for k, variant in local.metrics_response_time_variants : k => {
    namespace = "AWS/ApplicationELB"
    name      = "TargetResponseTime"
    label     = "${variant.stat} response time"
    color     = variant.color
    stat      = variant.stat
    period    = 60

    dimensions = {
      LoadBalancer = var.create ? data.aws_lb.lb[0].arn_suffix : ""
      TargetGroup  = var.create ? aws_lb_target_group.service[0].arn_suffix : ""
    }
  } }
}

locals {
  metrics_tasks_variants = {
    desired = { state = "Desired", color = local.colors.grey }
    pending = { state = "Pending", color = local.colors.orange }
    running = { state = "Running", color = local.colors.light_green }
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

module "metric_healthy_tasks" {
  source = "./../../../cloudwatch/metric"

  namespace = "AWS/ApplicationELB"
  name      = "HealthyHostCount"
  label     = "Healthy task count"
  color     = local.colors.green
  stat      = "Average"
  period    = 60

  dimensions = {
    LoadBalancer = var.create ? data.aws_lb.lb[0].arn_suffix : ""
    TargetGroup  = var.create ? aws_lb_target_group.service[0].arn_suffix : ""
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

locals {
  cluster_name = var.create ? substr(data.aws_arn.cluster[0].resource, length("cluster/"), -1) : ""
  container    = var.container != null ? var.container : var.name

  # make sure the default doesn't exceed 32 characters
  default_target_group_name = "${substr(
    local.cluster_name,
    0,
    min(length(local.cluster_name), 31 - length(var.name)),
  )}-${var.name}"
  target_group_name = var.target_group_name != null ? var.target_group_name : local.default_target_group_name
}

data "aws_arn" "cluster" {
  count = var.create ? 1 : 0

  arn = var.cluster_arn
}

resource "aws_ecs_service" "service" {
  count = var.create ? 1 : 0

  # make sure the target group is attached to a load balancer to avoid:
  # Error: InvalidParameterException: The target group with targetGroupArn
  #        (...) does not have an associated load balancer.
  depends_on = [aws_lb_listener_rule.service]

  name                               = var.name
  cluster                            = var.cluster_arn
  task_definition                    = var.task_definition_arn
  desired_count                      = var.desired_count
  launch_type                        = var.launch_type
  scheduling_strategy                = "REPLICA"
  deployment_maximum_percent         = var.deployment_max_percent
  deployment_minimum_healthy_percent = var.deployment_min_percent
  iam_role                           = var.role_arn

  load_balancer {
    target_group_arn = aws_lb_target_group.service[0].arn
    container_name   = local.container
    container_port   = var.container_port
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group" "service" {
  count = var.create ? 1 : 0

  name                 = local.target_group_name
  protocol             = "HTTP"
  port                 = var.container_port
  vpc_id               = var.vpc_id
  deregistration_delay = var.deregistration_delay
  slow_start           = var.slow_start

  health_check {
    path                = var.healthcheck_path
    matcher             = var.healthcheck_status
    interval            = var.healthcheck_interval
    timeout             = var.healthcheck_timeout
    healthy_threshold   = var.healthy_threshold
    unhealthy_threshold = var.unhealthy_threshold
  }
}

resource "aws_lb_listener_rule" "service" {
  count = var.create ? 1 : 0

  listener_arn = var.listener_arn

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.service[0].arn
  }

  condition {
    field  = "host-header"
    values = [var.rule_domain]
  }

  condition {
    field  = "path-pattern"
    values = [var.rule_path]
  }
}

# cloudwatch metrics ----------------------------------------------------------

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

module "metric_2xx_responses_ratio" {
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

module "metric_3xx_responses_ratio" {
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

module "metric_4xx_responses_ratio" {
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

module "metric_5xx_responses_ratio" {
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

module "metric_connection_errors_ratio" {
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

module "metric_tasks" {
  source = "./../../../cloudwatch/metric"

  namespace = "AWS/ECS"
  name      = "CPUUtilization"
  label     = "Task count"
  stat      = "SampleCount"
  period    = 60

  dimensions = {
    ServiceName = var.name
    ClusterName = local.cluster_name
  }
}

data "aws_ecs_container_definition" "web" {
  count = var.create ? 1 : 0

  task_definition = var.task_definition_arn
  container_name  = local.container
}

locals {
  cpu_reservation    = var.create ? data.aws_ecs_container_definition.web[0].cpu : 0
  memory_reservation = var.create ? data.aws_ecs_container_definition.web[0].memory_reservation : 0
}

module "metric_min_cpu_utilization" {
  source = "./../../../cloudwatch/metric"

  namespace = "AWS/ECS"
  name      = "CPUUtilization"
  label     = "Minimum CPU utilization"
  color     = local.colors.green
  stat      = "Minimum"
  period    = 60

  dimensions = {
    ServiceName = var.name
    ClusterName = local.cluster_name
  }
}

module "metric_average_cpu_utilization" {
  source = "./../../../cloudwatch/metric"

  namespace = "AWS/ECS"
  name      = "CPUUtilization"
  label     = "Average CPU utilization"
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

  namespace = "AWS/ECS"
  name      = "CPUUtilization"
  label     = "Maximum CPU utilization"
  color     = local.colors.red
  stat      = "Maximum"
  period    = 60

  dimensions = {
    ServiceName = var.name
    ClusterName = local.cluster_name
  }
}

module "metric_min_memory_utilization" {
  source = "./../../../cloudwatch/metric"

  namespace = "AWS/ECS"
  name      = "MemoryUtilization"
  label     = "Minimum memory utilization"
  color     = local.colors.green
  stat      = "Minimum"
  period    = 60

  dimensions = {
    ServiceName = var.name
    ClusterName = local.cluster_name
  }
}

module "metric_average_memory_utilization" {
  source = "./../../../cloudwatch/metric"

  namespace = "AWS/ECS"
  name      = "MemoryUtilization"
  label     = "Average memory utilization"
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

  namespace = "AWS/ECS"
  name      = "MemoryUtilization"
  label     = "Maximum memory utilization"
  color     = local.colors.red
  stat      = "Maximum"
  period    = 60

  dimensions = {
    ServiceName = var.name
    ClusterName = local.cluster_name
  }
}

# cloudwatch dashboard widgets ------------------------------------------------

module "widget_responses" {
  source = "./../../../cloudwatch/metric_widget"

  title   = "Responses"
  stacked = true
  left_metrics = [
    module.metric_connection_errors,
    module.metric_5xx_responses,
    module.metric_4xx_responses,
    module.metric_3xx_responses,
    module.metric_2xx_responses,
  ]
}

module "widget_response_ratios" {
  source = "./../../../cloudwatch/metric_widget"

  title   = "Response ratios"
  stacked = true
  left_metrics = [
    module.metric_connection_errors_ratio,
    module.metric_5xx_responses_ratio,
    module.metric_4xx_responses_ratio,
    module.metric_3xx_responses_ratio,
    module.metric_2xx_responses_ratio,
  ]
  left_range = [0, 100]
  hidden_metrics = [
    module.metric_requests,
    module.metric_2xx_responses,
    module.metric_3xx_responses,
    module.metric_4xx_responses,
    module.metric_5xx_responses,
    module.metric_connection_errors,
  ]
}

module "widget_response_time" {
  source = "./../../../cloudwatch/metric_widget"

  title   = "Response time"
  stacked = true
  left_metrics = [
    merge(module.metric_p50_response_time, { color = local.colors.red }),
    merge(module.metric_p95_response_time, { color = local.colors.orange }),
    merge(module.metric_p99_response_time, { color = local.colors.light_red }),
    merge(module.metric_max_response_time, { color = local.colors.light_orange }),
  ]
}

module "widget_tasks" {
  source = "./../../../cloudwatch/metric_widget"

  title        = "Tasks"
  left_metrics = [module.metric_tasks]
  left_range   = [0, null]
}

module "annotation_cpu_reservation" {
  source = "./../../../cloudwatch/annotation"

  value = 100
  label = "Reservation - ${local.cpu_reservation / 1024} vCPU"
  color = local.colors.grey
}

module "widget_cpu" {
  source = "./../../../cloudwatch/metric_widget"

  title = "CPU utilization"
  left_metrics = [
    module.metric_min_cpu_utilization,
    module.metric_average_cpu_utilization,
    module.metric_max_cpu_utilization,
  ]
  left_annotations = [module.annotation_cpu_reservation]
  left_range       = [0, null]
}

module "annotation_memory_reservation" {
  source = "./../../../cloudwatch/annotation"

  value = 100
  label = "Reservation - ${local.memory_reservation} MB"
  color = local.colors.grey
}

module "widget_memory" {
  source = "./../../../cloudwatch/metric_widget"

  title = "Memory utilization"
  left_metrics = [
    module.metric_min_memory_utilization,
    module.metric_average_memory_utilization,
    module.metric_max_memory_utilization,
  ]
  left_annotations = [module.annotation_memory_reservation]
  left_range       = [0, null]
}

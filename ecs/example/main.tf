locals {
  project       = "terraform-modules-ecs"
  project_index = 0
  environment   = "example"

  name = "${local.project}-${local.environment}"

  instance_attribute_name = "${local.name}-host-group"
}

provider "aws" {
  region = "eu-west-1"
}

module "cluster" {
  source = "./.."

  project                  = local.project
  project_index            = local.project_index
  environment              = local.environment
  availability_zones_count = 1
  nat_instance             = true
}

module "hosts" {
  source = "./../host_group"

  project     = local.project
  environment = local.environment
  size        = 1

  instance_type     = "t3.micro"
  instance_profile  = module.cluster.host_profile_name
  subnet_ids        = module.cluster.private_subnet_ids
  security_group_id = module.cluster.hosts_security_group_id
  cluster_name      = module.cluster.name

  instance_attributes = { (local.instance_attribute_name) = "main" }
}

module "repo" {
  source = "./../repository"

  project    = local.project
  image_name = "httpbin"
}

module "statsd_daemon" {
  source = "./../services/statsd"

  cluster_arn = module.cluster.arn
}

module "worker_task" {
  source = "./../task"

  project           = local.project
  environment       = local.environment
  task              = "worker"
  image             = "kennethreitz/httpbin:latest"
  memory_soft_limit = 32
  memory_hard_limit = 64
  cpu               = 128

  environment_variables = {
    DEBUG            = "True"
    HTTPBIN_TRACKING = "enabled"
  }
}

module "worker" {
  source = "./../services/worker"

  name                = "worker"
  cluster_arn         = module.cluster.arn
  task_definition_arn = module.worker_task.arn
  desired_count       = 1
}

module "web_task" {
  source = "./../task"

  project           = local.project
  environment       = local.environment
  task              = "web"
  image             = "kennethreitz/httpbin:latest"
  memory_soft_limit = 32
  memory_hard_limit = 64
  cpu               = 128
  ports             = [80]

  environment_variables = {
    DEBUG            = "True"
    HTTPBIN_TRACKING = "enabled"
  }

  placement_constraint_expressions = ["attribute:${local.instance_attribute_name} == main"]
}

module "web" {
  source = "./../services/web"

  name                = "web"
  cluster_arn         = module.cluster.arn
  task_definition_arn = module.web_task.arn
  desired_count       = 2

  vpc_id           = module.cluster.vpc_id
  listener_arn     = module.cluster.http_listener_arn
  role_arn         = module.cluster.web_service_role_arn
  rule_domain      = module.cluster.load_balancer_domain
  healthcheck_path = "/"
}

module "runner_task" {
  source = "./../task"

  project           = local.project
  environment       = local.environment
  task              = "runner"
  container         = "node"
  image             = "node:18-slim"
  memory_soft_limit = 32
  memory_hard_limit = 64
  cpu               = 128
}

module "random_uuid" {
  source = "./../run_task"

  cluster_arn         = module.cluster.arn
  task_definition_arn = module.runner_task.arn
  task_overrides = jsonencode({
    containerOverrides = [{
      name    = "node",
      command = ["node", "-e", "console.log('UUID:', require('crypto').randomUUID())"],
    }]
  })
}

module "dashboard" {
  source = "./../../cloudwatch/dashboard"

  name = "terraform-ecs-example"
  widgets = [
    module.cluster.widgets.cpu_utilization,
    module.cluster.widgets.memory_utilization,
    module.cluster.widgets.instances,
    module.cluster.widgets.services,
    module.cluster.widgets.tasks,
    module.cluster.lb_widgets.responses,
    module.cluster.lb_widgets.response_percentages,
    module.cluster.lb_widgets.target_response_time,
    module.cluster.lb_widgets.connections,
    module.cluster.lb_widgets.lcus,
    module.cluster.lb_widgets.traffic,
    module.cluster.nat_instance_widgets.cpu_utilization,
    module.cluster.nat_instance_widgets.cpu_credit_balance,
    module.cluster.nat_instance_widgets.cpu_credit_usage,
    module.cluster.nat_instance_widgets.network_bytes,
    module.cluster.nat_instance_widgets.network_packets,

    module.hosts.widgets.instance_scaling,
    module.hosts.widgets.instance_states,
    module.hosts.widgets.memory_utilization,
    module.hosts.widgets.cpu_utilization,
    module.hosts.widgets.cpu_credit_balance,
    module.hosts.widgets.cpu_credit_usage,
    module.hosts.widgets.root_fs_utilization,
    module.hosts.widgets.root_fs_free,
    module.hosts.widgets.fs_io_bytes,
    module.hosts.widgets.fs_io_ops,
    module.hosts.widgets.network_bytes,
    module.hosts.widgets.network_packets,

    module.web.widgets.responses,
    module.web.widgets.response_percentages,
    module.web.widgets.response_time,
    module.web.widgets.scaling,
    module.web.widgets.cpu_utilization,
    module.web.widgets.memory_utilization,
    module.worker.widgets.scaling,
    module.worker.widgets.cpu_utilization,
    module.worker.widgets.memory_utilization,
  ]
}

output "hosts_id" {
  value = module.hosts.id
}

output "dashboard_url" {
  value = module.dashboard.url
}

output "lb_url" {
  value = "http://${module.cluster.load_balancer_domain}"
}

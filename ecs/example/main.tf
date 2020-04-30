locals {
  project       = "terraform-modules-ecs"
  project_index = 0
  environment   = "example"

  name = "${local.project}-${local.environment}"
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
  nat_instance             = false
}

module "hosts" {
  source = "./../host_group"

  project     = local.project
  environment = local.environment
  size        = 1

  instance_type     = "t3.nano"
  instance_profile  = module.cluster.host_profile_name
  subnet_ids        = module.cluster.private_subnet_ids
  security_group_id = module.cluster.hosts_security_group_id
  cluster_name      = module.cluster.name
}

module "repo" {
  source = "./../repository"

  project    = local.project
  image_name = "httpbin"
}

module "worker_task" {
  source = "./../task"

  project           = local.project
  environment       = local.environment
  task              = "worker"
  image             = "kennethreitz/httpbin:latest"
  memory_soft_limit = 128

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
  memory_soft_limit = 128
  ports             = [80]

  environment_variables = {
    DEBUG            = "True"
    HTTPBIN_TRACKING = "enabled"
  }
}

module "web" {
  source = "./../services/web"

  name                = "web"
  cluster_arn         = module.cluster.arn
  task_definition_arn = module.web_task.arn
  desired_count       = 1

  vpc_id           = module.cluster.vpc_id
  listener_arn     = module.cluster.http_listener_arn
  role_arn         = module.cluster.web_service_role_arn
  rule_domain      = module.cluster.load_balancer_domain
  healthcheck_path = "/"
}

module "dashboard" {
  source = "./../../cloudwatch/dashboard"

  name = "terraform-ecs-example"
  widgets = [
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
    module.cluster.nat_gateway_widgets.network_bytes,
    module.cluster.nat_gateway_widgets.network_packets,
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

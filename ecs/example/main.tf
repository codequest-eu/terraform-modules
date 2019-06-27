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
  source = ".."

  project                  = "${local.project}"
  project_index            = "${local.project_index}"
  environment              = "${local.environment}"
  availability_zones_count = 1
}

module "hosts" {
  source = "../host_group"

  project     = "${local.project}"
  environment = "${local.environment}"
  size        = 1

  instance_type     = "t3.nano"
  instance_profile  = "${module.cluster.host_profile_name}"
  subnet_ids        = ["${module.cluster.private_subnet_ids}"]
  security_group_id = "${module.cluster.hosts_security_group_id}"
  cluster_name      = "${module.cluster.name}"
  bastion_key_name  = "${module.cluster.bastion_key_name}"
}

module "repo" {
  source = "../repository"

  project = "${local.project}"
}

module "worker_task" {
  source = "../task"

  project           = "${local.project}"
  environment       = "${local.environment}"
  task              = "worker"
  image             = "kennethreitz/httpbin:latest"
  memory_soft_limit = 128
}

module "worker" {
  source = "../services/worker"

  name                = "worker"
  cluster_arn         = "${module.cluster.arn}"
  task_definition_arn = "${module.worker_task.arn}"
  desired_count       = 1
}

module "httpbin" {
  source = "../services/web_service"

  project     = "tfm-ecs"
  environment = "${local.environment}"
  name        = "httpbin"
  image       = "kennethreitz/httpbin:latest"
  count       = 1

  listener_arn = "${module.cluster.http_listener_arn}"
  domain       = "${module.cluster.load_balancer_domain}"
  path         = "*"

  vpc_id      = "${module.cluster.vpc_id}"
  cluster_arn = "${module.cluster.arn}"
  role_name   = "${module.cluster.web_service_role_name}"
}

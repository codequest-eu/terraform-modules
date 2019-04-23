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

module "host" {
  source = "../host"

  name        = "${local.name}-host"
  project     = "${local.project}"
  environment = "${local.environment}"

  instance_type     = "t3.micro"
  instance_profile  = "${module.cluster.host_profile_name}"
  subnet_id         = "${module.cluster.private_subnet_ids[0]}"
  security_group_id = "${module.cluster.hosts_security_group_id}"
  cluster_name      = "${module.cluster.name}"
}

module "repo" {
  source = "../repository"

  project = "${local.project}"
}

module "httpbin" {
  source = "../tasks/web_service"

  project     = "tfm-ecs"
  environment = "${local.environment}"
  name        = "httpbin"
  image       = "kennethreitz/httpbin:latest"
  count       = 3

  listener_arn = "${module.cluster.http_listener_arn}"
  domain       = "${module.cluster.load_balancer_domain}"
  path         = "*"

  vpc_id      = "${module.cluster.vpc_id}"
  cluster_arn = "${module.cluster.arn}"
  role_name   = "${module.cluster.web_service_role_name}"
}

locals {
  project       = "terraform-modules-ecs"
  project_index = 0
  environment   = "example"

  name = "${local.project}-${local.environment}"
}

provider "aws" {
  region = "eu-west-1"
}

module "network" {
  source = "../network"

  project                  = "${local.project}"
  project_index            = "${local.project_index}"
  environment              = "${local.environment}"
  availability_zones_count = 2
}

module "access" {
  source = "../access"

  project     = "${local.project}"
  environment = "${local.environment}"
}

resource "aws_ecs_cluster" "cluster" {
  name = "${local.project}-${local.environment}"
}

module "host" {
  source = "../host"

  name        = "${local.name}-host"
  project     = "${local.project}"
  environment = "${local.environment}"

  instance_type     = "t3.micro"
  instance_profile  = "${module.access.host_profile_name}"
  subnet_id         = "${module.network.private_subnet_ids[0]}"
  security_group_id = "${module.network.hosts_security_group_id}"
  cluster_name      = "${aws_ecs_cluster.cluster.name}"
}

module "httpbin" {
  source = "../tasks/web_service"

  name  = "httpbin"
  image = "kennethreitz/httpbin:latest"
  count = 3

  listener_arn = "${module.network.http_listener_arn}"
  domain       = "${module.network.load_balancer_domain}"
  path         = "*"

  vpc_id      = "${module.network.vpc_id}"
  cluster_arn = "${aws_ecs_cluster.cluster.arn}"
  role_name   = "${module.access.web_service_role_name}"
}

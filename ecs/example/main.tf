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

module "worker_role" {
  source = "../worker_role"

  project     = "${local.project}"
  environment = "${local.environment}"
}

resource "aws_ecs_cluster" "cluster" {
  name = "${local.project}-${local.environment}"
}

module "worker" {
  source = "../worker"

  name        = "${local.name}-worker"
  project     = "${local.project}"
  environment = "${local.environment}"

  instance_type     = "t3.micro"
  instance_profile  = "${module.worker_role.profile_name}"
  subnet_id         = "${module.network.private_subnet_ids[0]}"
  security_group_id = "${module.network.workers_security_group_id}"
  cluster_name      = "${aws_ecs_cluster.cluster.name}"
}

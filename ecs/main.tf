module "network" {
  source = "./network"
  create = var.create

  project                  = var.project
  project_index            = var.project_index
  environment              = var.environment
  availability_zones_count = var.availability_zones_count
  nat_instance             = var.nat_instance
  nat_instance_type        = var.nat_instance_type
  enable_dns_support       = var.enable_dns_support
  enable_dns_hostnames     = var.enable_dns_hostnames
  lb_ssl_policy            = var.lb_ssl_policy
  tags                     = var.tags
}

module "access" {
  source = "./access"
  create = var.create

  project     = var.project
  environment = var.environment
}

resource "aws_ecs_cluster" "cluster" {
  count = var.create ? 1 : 0

  name = "${var.project}-${var.environment}"

  setting {
    name  = "containerInsights"
    value = "enabled"
  }
}

module "network" {
  source = "./network"

  project                     = var.project
  project_index               = var.project_index
  environment                 = var.environment
  availability_zones_count    = var.availability_zones_count
  bastion_ingress_cidr_blocks = [var.bastion_ingress_cidr_blocks]
  nat_instance                = var.nat_instance
  nat_instance_type           = var.nat_instance_type
  tags                        = var.tags
}

module "access" {
  source = "./access"

  project     = var.project
  environment = var.environment
}

resource "aws_ecs_cluster" "cluster" {
  name = "${var.project}-${var.environment}"
}


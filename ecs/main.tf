module "network" {
  source = "./network"
  create = var.create

  project                     = var.project
  project_index               = var.project_index
  environment                 = var.environment
  availability_zones_count    = var.availability_zones_count
  bastion_ingress_cidr_blocks = var.bastion_ingress_cidr_blocks
  bastion_instance_ami_name   = var.bastion_instance_ami_name
  nat_instance                = var.nat_instance
  nat_instance_type           = var.nat_instance_type
  nat_instance_ami_name       = var.nat_instance_ami_name
  tags                        = var.tags
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
}


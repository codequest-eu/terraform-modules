locals {
  project       = "terraform-modules-ecs"
  project_index = 0
  environment   = "example"
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

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
  nat_instance             = true
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
  bastion_key_name  = module.cluster.bastion_key_name
}

module "repo" {
  source = "./../repository"

  project = local.project
}

module "worker_task" {
  source = "./../task"

  project           = local.project
  environment       = local.environment
  task              = "worker"
  image             = "kennethreitz/httpbin:latest"
  memory_soft_limit = 128
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

output "bastion" {
  value = {
    host        = module.cluster.bastion_public_ips[0]
    private_key = module.cluster.bastion_private_key
  }
  sensitive = true
}

output "host_ip" {
  value = module.hosts.instance_private_ips[0]
}

resource "null_resource" "on_bastion" {
  triggers = {
    ip = module.cluster.bastion_public_ips[0]
  }

  connection {
    type        = "ssh"
    agent       = false
    user        = "ec2-user"
    host        = module.cluster.bastion_public_ips[0]
    private_key = module.cluster.bastion_private_key
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Bastion'",
      "cat /etc/os-release",
      "uname -r"
    ]
  }
}

resource "null_resource" "on_host" {
  triggers = {
    ip = module.hosts.instance_private_ips[0]
  }

  connection {
    type                = "ssh"
    agent               = false
    user                = "ec2-user"
    host                = module.hosts.instance_private_ips[0]
    private_key         = module.cluster.bastion_private_key
    bastion_user        = "ec2-user"
    bastion_host        = module.cluster.bastion_public_ips[0]
    bastion_private_key = module.cluster.bastion_private_key
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Host'",
      "cat /etc/os-release",
      "uname -r"
    ]
  }
}

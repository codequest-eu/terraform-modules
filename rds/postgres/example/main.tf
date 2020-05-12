provider "aws" {
  region = "eu-west-1"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_availability_zones" "all" {
}

data "aws_subnet" "a" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = data.aws_availability_zones.all.names[0]
  default_for_az    = true
}

data "aws_subnet" "b" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = data.aws_availability_zones.all.names[1]
  default_for_az    = true
}

resource "random_string" "master_password" {
  length  = 32
  special = false
}

module "db" {
  source = "./.."

  project     = "terraform-modules-postgres"
  environment = "example"

  vpc_id     = data.aws_vpc.default.id
  subnet_ids = [data.aws_subnet.a.id, data.aws_subnet.b.id]
  multi_az   = false

  instance_type = "db.t2.micro"
  storage       = 20
  public        = true
  username      = "terraform_modules"
  password      = random_string.master_password.result

  prevent_destroy = false
}

output "master_db_url" {
  value     = module.db.url
  sensitive = true
}

locals {
  environments = toset(["development", "production"])
}

resource "random_password" "environment_password" {
  for_each = local.environments

  length  = 32
  special = false
}

resource "null_resource" "create_environment_db" {
  for_each = local.environments

  triggers = {
    db       = "terraform_modules_${each.key}"
    password = random_password.environment_password[each.key].result
  }

  provisioner "local-exec" {
    when    = create
    command = module.db.management_lambda.invoke_script

    environment = {
      EVENT = jsonencode({
        commands = [
          {
            path = "user.create"
            options = {
              user     = self.triggers.db
              password = self.triggers.password
            }
          },
          {
            path = "db.create"
            options = {
              db = self.triggers.db
            }
          },
          {
            path = "db.grantAll"
            options = {
              db   = self.triggers.db
              user = self.triggers.db
            }
          }
        ]
      })
    }
  }
}

resource "null_resource" "destroy_environment_db" {
  for_each   = local.environments
  depends_on = [null_resource.create_environment_db]

  triggers = {
    db = "terraform_modules_${each.key}"
  }

  provisioner "local-exec" {
    when    = destroy
    command = module.db.management_lambda.invoke_script

    environment = {
      EVENT = jsonencode({
        commands = [
          {
            path    = "db.drop"
            options = { db = self.triggers.db }
          },
          {
            path    = "user.drop"
            options = { user = self.triggers.db }
          },
        ]
      })
    }
  }
}

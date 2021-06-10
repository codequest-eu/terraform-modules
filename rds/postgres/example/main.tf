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

# Management lambda invocation examples ---------------------------------------

locals {
  environments = toset(["development", "production"])
}

resource "null_resource" "environment_db_user" {
  depends_on = [module.db]
  for_each   = local.environments

  triggers = {
    name = "terraform_modules_${each.key}"
  }

  provisioner "local-exec" {
    when    = create
    command = "${path.module}/bin/psql_invoke"
    environment = { EVENT = jsonencode({
      queries = [
        "CREATE ROLE ${self.triggers.name} WITH LOGIN",
        "GRANT ${self.triggers.name} TO ${module.db.username}",
      ]
    }) }
  }

  provisioner "local-exec" {
    when    = destroy
    command = "${path.module}/bin/psql_invoke"
    environment = { EVENT = jsonencode({
      queries = ["DROP ROLE ${self.triggers.name}"]
    }) }
  }
}

resource "random_password" "environment_db_password" {
  for_each = local.environments

  length  = 32
  special = false
}

resource "null_resource" "environment_db_password" {
  depends_on = [module.db]
  for_each   = local.environments

  triggers = {
    name     = null_resource.environment_db_user[each.key].triggers.name
    password = random_password.environment_db_password[each.key].result
  }

  provisioner "local-exec" {
    when    = create
    command = <<-EOT
      ${path.module}/bin/psql_invoke 2>&1 \
      | sed "s/$SENSITIVE_PATTERN/(sensitive)/"
    EOT

    environment = {
      SENSITIVE_PATTERN = self.triggers.password
      EVENT = jsonencode({
        queries = [
          "ALTER ROLE ${self.triggers.name} WITH PASSWORD '${self.triggers.password}'"
        ]
      })
    }
  }
}

resource "null_resource" "environment_db" {
  depends_on = [module.db]
  for_each   = local.environments

  triggers = {
    name  = null_resource.environment_db_user[each.key].triggers.name
    owner = null_resource.environment_db_user[each.key].triggers.name
  }

  provisioner "local-exec" {
    when    = create
    command = "${path.module}/bin/psql_invoke"
    environment = { EVENT = jsonencode({
      queries = [
        "CREATE DATABASE ${self.triggers.name} OWNER ${self.triggers.owner}"
      ]
    }) }
  }

  provisioner "local-exec" {
    when    = destroy
    command = "${path.module}/bin/psql_invoke"
    environment = { EVENT = jsonencode({
      queries = ["DROP DATABASE ${self.triggers.name}"]
    }) }
  }
}

locals {
  environment_dbs = {
    for environment in local.environments : environment => {
      name     = null_resource.environment_db[environment].triggers.name
      user     = null_resource.environment_db_user[environment].triggers.name
      password = null_resource.environment_db_password[environment].triggers.password
    }
  }
  environment_db_urls = {
    for environment, database in local.environment_dbs : environment =>
    "postgres://${database.user}:${database.password}@${module.db.host}:${module.db.port}/${database.name}"
  }
}

output "development_db_url" {
  value     = local.environment_db_urls.development
  sensitive = true
}

output "production_db_url" {
  value     = local.environment_db_urls.production
  sensitive = true
}

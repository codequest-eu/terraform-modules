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

resource "random_password" "master_password" {
  length  = 32
  special = false
}

module "db" {
  source = "./.."

  project     = "terraform-modules-mysql"
  environment = "example"

  vpc_id     = data.aws_vpc.default.id
  subnet_ids = [data.aws_subnet.a.id, data.aws_subnet.b.id]
  multi_az   = false

  instance_type = "db.t2.micro"
  storage       = 20
  public        = true
  username      = "terraform_modules"
  password      = random_password.master_password.result

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
  for_each = local.environments

  triggers = {
    name = "terraform_modules_${each.key}"
  }

  provisioner "local-exec" {
    when    = create
    command = module.db.management_lambda.invoke_script
    environment = { EVENT = jsonencode({
      queries = ["CREATE USER '${self.triggers.name}'@'%'"]
    }) }
  }

  provisioner "local-exec" {
    when    = destroy
    command = module.db.management_lambda.invoke_script
    environment = { EVENT = jsonencode({
      queries = ["DROP USER '${self.triggers.name}'@'%'"]
    }) }
  }
}

resource "random_password" "environment_db_password" {
  for_each = local.environments

  length  = 32
  special = false
}

resource "null_resource" "environment_db_password" {
  for_each = local.environments

  triggers = {
    name     = null_resource.environment_db_user[each.key].triggers.name
    password = random_password.environment_db_password[each.key].result
  }

  provisioner "local-exec" {
    when    = create
    command = module.db.management_lambda.invoke_script
    environment = { EVENT = jsonencode({
      queries = [
        "ALTER USER '${self.triggers.name}'@'%' IDENTIFIED BY '${self.triggers.password}'"
      ]
    }) }
  }
}

resource "null_resource" "environment_db" {
  for_each = local.environments

  triggers = {
    name  = null_resource.environment_db_user[each.key].triggers.name
    owner = null_resource.environment_db_user[each.key].triggers.name
  }

  provisioner "local-exec" {
    when    = create
    command = module.db.management_lambda.invoke_script
    environment = { EVENT = jsonencode({
      queries = [
        "CREATE DATABASE ${self.triggers.name}",
        "GRANT ALL ON ${self.triggers.name}.* TO '${self.triggers.owner}'@'%'"
      ]
    }) }
  }

  provisioner "local-exec" {
    when    = destroy
    command = module.db.management_lambda.invoke_script
    environment = { EVENT = jsonencode({
      queries = ["DROP DATABASE ${self.triggers.name}"]
    }) }
  }
}

locals {
  environment_dbs = {
    for environment in local.environments : environment => {
      host     = module.db.host
      port     = module.db.port
      name     = null_resource.environment_db[environment].triggers.name
      user     = null_resource.environment_db_user[environment].triggers.name
      password = null_resource.environment_db_password[environment].triggers.password
    }
  }
  environment_db_urls = {
    for environment, database in local.environment_dbs : environment =>
    "mysql://${database.user}:${database.password}@${database.host}:${database.port}/${database.name}"
  }
}

output "development_db" {
  value     = local.environment_dbs.development
  sensitive = true
}

output "development_db_url" {
  value     = local.environment_db_urls.development
  sensitive = true
}

output "production_db" {
  value     = local.environment_dbs.production
  sensitive = true
}

output "production_db_url" {
  value     = local.environment_db_urls.production
  sensitive = true
}

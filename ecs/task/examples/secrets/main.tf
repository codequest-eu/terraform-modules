provider "aws" {
  region = "eu-west-1"
}

locals {
  name = "terraform-modules-example-ecs-task-task-secrets"
}

# Generate a random password and save it as an SSM Parameter
resource "random_password" "database" {
  length = 16
}

resource "aws_ssm_parameter" "database_password" {
  name  = "/${local.name}/DB_PASSWORD"
  type  = "SecureString"
  value = random_password.database.result
}

# Prepare a task execution role that gives ECS access to SSM parameters
data "aws_iam_policy_document" "get_parameters" {
  statement {
    actions   = ["ssm:GetParameters"]
    resources = [aws_ssm_parameter.database_password.arn]
  }
}

module "database_client_execution_role" {
  source = "./../../role"

  name           = "${local.name}-execution"
  execution_role = true
  policies       = { get_parameters = data.aws_iam_policy_document.get_parameters.json }
}

# Create a task definition which uses the parameter
module "database_client" {
  source = "./../.."

  project           = "terraform-modules"
  environment       = "example"
  task              = "ecs-task-secrets"
  container         = "database_client"
  image             = "alpine:latest"
  cpu               = 256
  memory_soft_limit = 128
  memory_hard_limit = 512
  network_mode      = "awsvpc"

  command = ["sh", "-c",
    <<EOT
      env | grep '^DB_'
      DB_URL="postgres://$DB_USER:$DB_PASSWORD@$DB_HOST/$DB_NAME"
      echo "Connecting to $DB_URL..."
      sleep infinity
    EOT
  ]

  environment_variables = {
    DB_HOST = "db.example.com"
    DB_USER = "example"
    DB_NAME = "example"
  }

  environment_parameters = {
    DB_PASSWORD = aws_ssm_parameter.database_password
  }

  execution_role_arn = module.database_client_execution_role.arn
}

output "database_client" {
  value = module.database_client.arn
}

# Test the task definition by running it as a service using fargate
module "test_service" {
  source = "./../../test_service"

  cluster_name        = local.name
  task_definition_arn = module.database_client.arn
}

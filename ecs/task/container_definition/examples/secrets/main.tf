provider "aws" {
  region = "eu-west-1"
}

locals {
  name = "terraform-modules-example-ecs-task-container-secrets"
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

# Create a container definition which uses the parameter
module "database_client_log" {
  source = "./../../../log_group"

  project     = "terraform-modules"
  environment = "example"
  task        = "ecs-task-container"
}

module "database_client" {
  source = "./../.."

  name              = "database_client"
  image             = "alpine:latest"
  memory_soft_limit = 128
  memory_hard_limit = 256

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

  log_config = module.database_client_log.container_config
}

output "container_definition" {
  value = module.database_client.definition
}

# Prepare a task execution role that gives ECS access to SSM parameters
data "aws_iam_policy_document" "assume_role_by_ecs" {
  statement {
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "database_client_execution" {
  name               = "${local.name}-execution"
  assume_role_policy = data.aws_iam_policy_document.assume_role_by_ecs.json
}

resource "aws_iam_role_policy_attachment" "database_client_execution_base" {
  role       = aws_iam_role.database_client_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

data "aws_iam_policy_document" "get_parameters" {
  statement {
    actions   = ["ssm:GetParameters"]
    resources = [aws_ssm_parameter.database_password.arn]
  }
}

resource "aws_iam_role_policy" "database_client_execution_get_parameters" {
  role   = aws_iam_role.database_client_execution.name
  policy = data.aws_iam_policy_document.get_parameters.json
}

# Test the container definition by creating a task definition and
# running it as a service using fargate
resource "aws_ecs_task_definition" "database_client" {
  family                = local.name
  container_definitions = jsonencode([module.database_client.definition])
  execution_role_arn    = aws_iam_role.database_client_execution.arn

  cpu                      = 256
  memory                   = 512
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
}

resource "aws_ecs_cluster" "cluster" {
  name = local.name
}

data "aws_vpc" "default" {
  default = true
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  name   = "default"
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_ecs_service" "database_client" {
  name = local.name

  task_definition = aws_ecs_task_definition.database_client.arn
  cluster         = aws_ecs_cluster.cluster.arn
  launch_type     = "FARGATE"
  desired_count   = 1

  network_configuration {
    assign_public_ip = true
    security_groups  = [data.aws_security_group.default.id]
    subnets          = data.aws_subnet_ids.default.ids
  }
}

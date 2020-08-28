data "aws_region" "current" {
  count = var.create ? 1 : 0
}

# IAM Roles and policies
data "aws_iam_policy_document" "assume_by_ecs_task" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "task_role" {
  count = var.create ? 1 : 0

  name               = "${var.name}-task"
  assume_role_policy = data.aws_iam_policy_document.assume_by_ecs_task.json
}

resource "aws_iam_role_policy_attachment" "task_role" {
  for_each = toset(var.create ? ["CloudWatchAgentServerPolicy"] : [])

  role       = aws_iam_role.task_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/${each.key}"
}

resource "aws_iam_role" "task_execution_role" {
  count = var.create ? 1 : 0

  name               = "${var.name}-task-execution"
  assume_role_policy = data.aws_iam_policy_document.assume_by_ecs_task.json
}

resource "aws_iam_role_policy_attachment" "task_execution_role" {
  for_each = toset(var.create ? [
    "CloudWatchAgentServerPolicy",
    "service-role/AmazonECSTaskExecutionRolePolicy"
  ] : [])

  role       = aws_iam_role.task_execution_role[0].name
  policy_arn = "arn:aws:iam::aws:policy/${each.key}"
}

# Container logs
resource "aws_cloudwatch_log_group" "log" {
  count = var.create ? 1 : 0

  name = var.name
  tags = var.tags
}

# Container, task and service definitions
locals {
  agent_config = {
    agent = {
      debug = var.debug
    }

    metrics = {
      namespace = "statsd"

      metrics_collected = {
        statsd = {
          service_address              = ":8125"
          metrics_collection_interval  = var.collection_interval
          metrics_aggregation_interval = var.aggregation_interval
        }
      }

      append_dimensions = {
        "InstanceId" = "$${aws:InstanceId}"
      }

      aggregation_dimensions = [
        ["ServiceName"],
        ["ServiceName", "InstanceId"],
      ]
    }
  }

  container_definition = {
    name      = "cwagent"
    image     = "amazon/cloudwatch-agent:latest"
    essential = true

    cpu               = 128
    memory            = 64
    memoryReservation = 64

    environment = [
      { name = "USE_DEFAULT_CONFIG", value = "False" },
      { name = "CW_CONFIG_CONTENT", value = jsonencode(local.agent_config) }
    ]

    portMappings = [
      { containerPort = 8125, hostPort = var.port, protocol = "udp" }
    ]

    logConfiguration = var.create ? {
      "logDriver" = "awslogs"
      "options" = {
        "awslogs-group"         = aws_cloudwatch_log_group.log[0].name
        "awslogs-region"        = data.aws_region.current[0].name
        "awslogs-stream-prefix" = aws_cloudwatch_log_group.log[0].name
      }
    } : null
  }
}

resource "aws_ecs_task_definition" "task" {
  count = var.create ? 1 : 0

  family                = var.name
  container_definitions = jsonencode([local.container_definition])
  task_role_arn         = aws_iam_role.task_role[0].arn
  execution_role_arn    = aws_iam_role.task_execution_role[0].arn
}

resource "aws_ecs_service" "service" {
  count = var.create ? 1 : 0

  name                = var.name
  cluster             = var.cluster_arn
  task_definition     = aws_ecs_task_definition.task[0].arn
  launch_type         = "EC2"
  scheduling_strategy = "DAEMON"
}

# outputs

locals {
  host    = "172.17.0.1"
  address = "${local.host}:${var.port}"
}

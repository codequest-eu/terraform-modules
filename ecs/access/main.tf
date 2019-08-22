locals {
  name = "${var.project}-${var.environment}"
}

data "aws_iam_policy_document" "assume_ec2_role" {
  count = var.create ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "host" {
  count = var.create ? 1 : 0

  name               = "${local.name}-host"
  assume_role_policy = data.aws_iam_policy_document.assume_ec2_role[0].json
}

resource "aws_iam_role_policy_attachment" "host_ecs_for_ec2" {
  count = var.create ? 1 : 0

  role       = aws_iam_role.host[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "host_ec2_for_ssm" {
  count = var.create ? 1 : 0

  role       = aws_iam_role.host[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_role_policy_attachment" "host_cloudwatch_agent" {
  count = var.create ? 1 : 0

  role       = aws_iam_role.host[0].name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "host" {
  count = var.create ? 1 : 0

  name = aws_iam_role.host[0].name
  role = aws_iam_role.host[0].name
}

data "aws_iam_policy_document" "assume_ecs_role" {
  count = var.create ? 1 : 0

  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "web_service" {
  count = var.create ? 1 : 0

  name               = "${local.name}-web-service"
  assume_role_policy = data.aws_iam_policy_document.assume_ecs_role[0].json
}

resource "aws_iam_role_policy_attachment" "web_service_role" {
  count = var.create ? 1 : 0

  role       = aws_iam_role.web_service[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}


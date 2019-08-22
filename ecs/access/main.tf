locals {
  name = "${var.project}-${var.environment}"
}

data "aws_iam_policy_document" "assume_ec2_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "host" {
  name               = "${local.name}-host"
  assume_role_policy = data.aws_iam_policy_document.assume_ec2_role.json
}

resource "aws_iam_role_policy_attachment" "host_ecs_for_ec2" {
  role       = aws_iam_role.host.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

resource "aws_iam_role_policy_attachment" "host_ec2_for_ssm" {
  role       = aws_iam_role.host.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
}

resource "aws_iam_role_policy_attachment" "host_cloudwatch_agent" {
  role       = aws_iam_role.host.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "host" {
  name = aws_iam_role.host.name
  role = aws_iam_role.host.name
}

data "aws_iam_policy_document" "assume_ecs_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ecs.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "web_service" {
  name               = "${local.name}-web-service"
  assume_role_policy = data.aws_iam_policy_document.assume_ecs_role.json
}

resource "aws_iam_role_policy_attachment" "web_service_role" {
  role       = aws_iam_role.web_service.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceRole"
}


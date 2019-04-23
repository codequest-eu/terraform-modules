locals {
  default_tags = {
    Name        = "${var.name}"
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }

  tags = "${merge(local.default_tags, var.tags)}"
}

data "aws_ami" "ecs_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-ecs-hvm-2.0.20190301-x86_64-ebs"]
  }
}

data "template_file" "user_data" {
  template = "${file("${path.module}/templates/user_data.sh")}"

  vars {
    cluster_name = "${var.cluster_name}"
  }
}

resource "aws_instance" "host" {
  ami                    = "${data.aws_ami.ecs_amazon_linux.id}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${var.subnet_id}"
  vpc_security_group_ids = ["${var.security_group_id}"]
  iam_instance_profile   = "${var.instance_profile}"
  user_data              = "${data.template_file.user_data.rendered}"

  tags = "${local.tags}"
}

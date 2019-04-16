locals {
  project     = "terraform-modules-ecs"
  environment = "example"
  name        = "${local.project}-${local.environment}"

  tags = {
    Name        = "${local.name}"
    Project     = "${local.project}"
    Environment = "${local.environment}"
  }

  index    = 0
  multi_az = true

  zone_count = "${local.multi_az ? 2 : 1}"
  zone_names = "${slice(data.aws_availability_zones.zones.names, 0, 3)}"

  # VPC address range
  vpc_block = "${cidrsubnet("10.0.0.0/8", 8, local.index)}"

  # Divide the VPC address range into 4 blocks, 3 for AZs and one spare
  zone_blocks = [
    "${cidrsubnet(local.vpc_block, 2, 0)}",
    "${cidrsubnet(local.vpc_block, 2, 1)}",
    "${cidrsubnet(local.vpc_block, 2, 2)}",
  ]

  # Give half of AZ address space for private networks
  zone_private_blocks = [
    "${cidrsubnet(local.zone_blocks[0], 1, 0)}",
    "${cidrsubnet(local.zone_blocks[1], 1, 0)}",
    "${cidrsubnet(local.zone_blocks[2], 1, 0)}",
  ]

  # Give a quarter of AZ address space for public networks, leaving a quarter spare
  zone_public_blocks = [
    "${cidrsubnet(cidrsubnet(local.zone_blocks[0], 1, 1), 1, 0)}",
    "${cidrsubnet(cidrsubnet(local.zone_blocks[1], 1, 1), 1, 0)}",
    "${cidrsubnet(cidrsubnet(local.zone_blocks[2], 1, 1), 1, 0)}",
  ]
}

provider "aws" {
  region = "eu-west-1"
}

data "aws_availability_zones" "zones" {}

resource "aws_vpc" "cloud" {
  cidr_block = "${local.vpc_block}"
  tags       = "${local.tags}"
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = "${aws_vpc.cloud.id}"
  tags   = "${local.tags}"
}

resource "aws_subnet" "private" {
  count = "${local.zone_count}"

  vpc_id                  = "${aws_vpc.cloud.id}"
  availability_zone       = "${element(local.zone_names, count.index)}"
  cidr_block              = "${element(local.zone_private_blocks, count.index)}"
  map_public_ip_on_launch = false
  tags                    = "${merge(local.tags, map("Name", "${local.name}-private-${count.index}"))}"
}

resource "aws_subnet" "public" {
  count = "${local.zone_count}"

  vpc_id                  = "${aws_vpc.cloud.id}"
  availability_zone       = "${element(local.zone_names, count.index)}"
  cidr_block              = "${element(local.zone_public_blocks, count.index)}"
  map_public_ip_on_launch = true
  tags                    = "${merge(local.tags, map("Name", "${local.name}-public-${count.index}"))}"
}

resource "aws_eip" "public_nat" {
  count      = "${local.zone_count}"
  depends_on = ["aws_internet_gateway.gateway"]

  vpc  = true
  tags = "${merge(local.tags, map("Name", "${local.name}-public-${count.index}"))}"
}

resource "aws_nat_gateway" "public" {
  count = "${local.zone_count}"

  allocation_id = "${element(aws_eip.public_nat.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
  tags          = "${merge(local.tags, map("Name", "${local.name}-public-${count.index}"))}"
}

resource "aws_security_group" "lb" {
  name   = "${local.name}-lb"
  vpc_id = "${aws_vpc.cloud.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${local.tags}"
}

resource "aws_lb" "lb" {
  name               = "${local.name}"
  load_balancer_type = "application"
  subnets            = ["${aws_subnet.private.*.id}"]
  security_groups    = ["${aws_security_group.lb.id}"]
  tags               = "${local.tags}"
}

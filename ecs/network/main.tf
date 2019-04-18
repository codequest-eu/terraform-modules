locals {
  name = "${var.project}-${var.environment}"

  default_tags = {
    Name        = "${local.name}"
    Project     = "${var.project}"
    Environment = "${var.environment}"
  }

  tags = "${merge(local.default_tags, var.tags)}"

  # VPC address range
  vpc_block = "${cidrsubnet("10.0.0.0/8", 8, var.project_index)}"
}

data "aws_availability_zones" "zones" {}

locals {
  az_names = "${slice(data.aws_availability_zones.zones.names, 0, 3)}"

  # Divide the VPC address range into 4 blocks, 3 for AZs and one spare
  az_blocks = [
    "${cidrsubnet(local.vpc_block, 2, 0)}",
    "${cidrsubnet(local.vpc_block, 2, 1)}",
    "${cidrsubnet(local.vpc_block, 2, 2)}",
  ]

  # Give half of AZ address space for private networks
  az_private_blocks = [
    "${cidrsubnet(local.az_blocks[0], 1, 0)}",
    "${cidrsubnet(local.az_blocks[1], 1, 0)}",
    "${cidrsubnet(local.az_blocks[2], 1, 0)}",
  ]

  # Give a quarter of AZ address space for public networks, leaving a quarter spare
  az_public_blocks = [
    "${cidrsubnet(cidrsubnet(local.az_blocks[0], 1, 1), 1, 0)}",
    "${cidrsubnet(cidrsubnet(local.az_blocks[1], 1, 1), 1, 0)}",
    "${cidrsubnet(cidrsubnet(local.az_blocks[2], 1, 1), 1, 0)}",
  ]
}

resource "aws_vpc" "cloud" {
  cidr_block = "${local.vpc_block}"
  tags       = "${local.tags}"
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = "${aws_vpc.cloud.id}"
  tags   = "${local.tags}"
}

resource "aws_subnet" "private" {
  count = "${var.availability_zones_count}"

  vpc_id                  = "${aws_vpc.cloud.id}"
  availability_zone       = "${element(local.az_names, count.index)}"
  cidr_block              = "${element(local.az_private_blocks, count.index)}"
  map_public_ip_on_launch = false
  tags                    = "${merge(local.tags, map("Name", "${local.name}-private-${count.index}"))}"
}

resource "aws_subnet" "public" {
  count = "${var.availability_zones_count}"

  vpc_id                  = "${aws_vpc.cloud.id}"
  availability_zone       = "${element(local.az_names, count.index)}"
  cidr_block              = "${element(local.az_public_blocks, count.index)}"
  map_public_ip_on_launch = true
  tags                    = "${merge(local.tags, map("Name", "${local.name}-public-${count.index}"))}"
}

resource "aws_eip" "public_nat" {
  count      = "${var.availability_zones_count}"
  depends_on = ["aws_internet_gateway.gateway"]

  vpc  = true
  tags = "${merge(local.tags, map("Name", "${local.name}-public-${count.index}"))}"
}

resource "aws_nat_gateway" "public" {
  count = "${var.availability_zones_count}"

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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(local.tags, map("Name", "${local.name}-lb"))}"
}

resource "aws_lb" "lb" {
  name               = "${local.name}"
  load_balancer_type = "application"
  subnets            = ["${aws_subnet.private.*.id}"]
  security_groups    = ["${aws_security_group.lb.id}"]
  tags               = "${local.tags}"
}

resource "aws_security_group" "hosts" {
  name   = "${local.name}-hosts"
  vpc_id = "${aws_vpc.cloud.id}"

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = ["${aws_security_group.lb.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = "${merge(local.tags, map("Name", "${local.name}-hosts"))}"
}

resource "aws_route_table" "private" {
  count = "${var.availability_zones_count}"

  vpc_id = "${aws_vpc.cloud.id}"
  tags   = "${merge(local.tags, map("Name", "${local.name}-private-${count.index}"))}"
}

resource "aws_route" "private_default" {
  count = "${var.availability_zones_count}"

  route_table_id         = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.public.*.id, count.index)}"
}

resource "aws_route_table_association" "private" {
  count = "${var.availability_zones_count}"

  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.cloud.id}"
  tags   = "${merge(local.tags, map("Name", "${local.name}-public"))}"
}

resource "aws_route" "public_default" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gateway.id}"
}

resource "aws_route_table_association" "public" {
  count = "${var.availability_zones_count}"

  route_table_id = "${aws_route_table.public.id}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
}

locals {
  name = "${var.project}-${var.environment}"

  default_tags = {
    Name        = local.name
    Project     = var.project
    Environment = var.environment
  }

  tags = merge(local.default_tags, var.tags)

  # VPC address range
  vpc_block = cidrsubnet("10.0.0.0/8", 8, var.project_index)
}

data "aws_availability_zones" "zones" {
}

locals {
  az_names = slice(data.aws_availability_zones.zones.names, 0, 3)

  # Divide the VPC address range into 4 blocks, 3 for AZs and one spare
  az_blocks = [
    cidrsubnet(local.vpc_block, 2, 0),
    cidrsubnet(local.vpc_block, 2, 1),
    cidrsubnet(local.vpc_block, 2, 2),
  ]

  # Give half of AZ address space for private networks
  az_private_blocks = [
    cidrsubnet(local.az_blocks[0], 1, 0),
    cidrsubnet(local.az_blocks[1], 1, 0),
    cidrsubnet(local.az_blocks[2], 1, 0),
  ]

  # Give a quarter of AZ address space for public networks, leaving a quarter spare
  az_public_blocks = [
    cidrsubnet(cidrsubnet(local.az_blocks[0], 1, 1), 1, 0),
    cidrsubnet(cidrsubnet(local.az_blocks[1], 1, 1), 1, 0),
    cidrsubnet(cidrsubnet(local.az_blocks[2], 1, 1), 1, 0),
  ]
}

resource "aws_vpc" "cloud" {
  cidr_block = local.vpc_block
  tags       = local.tags
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.cloud.id
  tags   = local.tags
}

resource "aws_subnet" "private" {
  count = var.availability_zones_count

  vpc_id                  = aws_vpc.cloud.id
  availability_zone       = element(local.az_names, count.index)
  cidr_block              = element(local.az_private_blocks, count.index)
  map_public_ip_on_launch = false
  tags = merge(
    local.tags,
    {
      "Name" = "${local.name}-private-${count.index}"
    },
  )
}

resource "aws_subnet" "public" {
  # HACK: ALB requires at least 2 subnets in different AZs
  count = max(2, var.availability_zones_count)

  vpc_id                  = aws_vpc.cloud.id
  availability_zone       = element(local.az_names, count.index)
  cidr_block              = element(local.az_public_blocks, count.index)
  map_public_ip_on_launch = true
  tags = merge(
    local.tags,
    {
      "Name" = "${local.name}-public-${count.index}"
    },
  )
}

resource "aws_eip" "public_nat" {
  count      = var.availability_zones_count
  depends_on = [aws_internet_gateway.gateway]

  vpc = true
  tags = merge(
    local.tags,
    {
      "Name" = "${local.name}-public-${count.index}"
    },
  )
}

resource "aws_nat_gateway" "public" {
  count = var.nat_instance ? 0 : var.availability_zones_count

  allocation_id = element(aws_eip.public_nat.*.id, count.index)
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  tags = merge(
    local.tags,
    {
      "Name" = "${local.name}-public-${count.index}"
    },
  )
}

data "aws_ami" "nat" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-vpc-nat-2018.03.0.20190611-x86_64-ebs"]
  }
}

resource "aws_instance" "nat" {
  count = var.nat_instance ? var.availability_zones_count : 0

  ami                    = data.aws_ami.nat.id
  instance_type          = var.nat_instance_type
  subnet_id              = element(aws_subnet.public.*.id, count.index)
  vpc_security_group_ids = [aws_security_group.nat[0].id]
  tags = merge(
    local.tags,
    {
      "Name" = "${local.name}-nat-${count.index}"
    },
  )
  key_name          = aws_key_pair.bastion.key_name
  source_dest_check = false
}

resource "aws_security_group" "nat" {
  count = var.nat_instance ? 1 : 0

  name   = "${local.name}-nat"
  vpc_id = aws_vpc.cloud.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion.id]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = local.az_private_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "lb" {
  name   = "${local.name}-lb"
  vpc_id = aws_vpc.cloud.id

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

  tags = merge(
    local.tags,
    {
      "Name" = "${local.name}-lb"
    },
  )
}

resource "aws_lb" "lb" {
  name               = local.name
  load_balancer_type = "application"
  subnets            = aws_subnet.public.*.id
  security_groups    = [aws_security_group.lb.id]
  tags               = local.tags
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_302"
    }
  }
}

resource "tls_private_key" "lb_default" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "lb_default" {
  key_algorithm         = "RSA"
  private_key_pem       = tls_private_key.lb_default.private_key_pem
  validity_period_hours = 365 * 24

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]

  subject {
    common_name = aws_lb.lb.dns_name
  }
}

resource "aws_acm_certificate" "lb_default" {
  private_key      = tls_private_key.lb_default.private_key_pem
  certificate_body = tls_self_signed_cert.lb_default.cert_pem
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.lb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = aws_acm_certificate.lb_default.arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Not Found"
      status_code  = "404"
    }
  }
}

resource "aws_security_group" "bastion" {
  name   = "${local.name}-bastions"
  vpc_id = aws_vpc.cloud.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = var.bastion_ingress_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.tags,
    {
      "Name" = "${local.name}-bastions"
    },
  )
}

resource "aws_security_group" "hosts" {
  name   = "${local.name}-hosts"
  vpc_id = aws_vpc.cloud.id

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"

    security_groups = [
      aws_security_group.lb.id,
      aws_security_group.bastion.id,
    ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    local.tags,
    {
      "Name" = "${local.name}-hosts"
    },
  )
}

resource "aws_route_table" "private" {
  count = var.availability_zones_count

  vpc_id = aws_vpc.cloud.id
  tags = merge(
    local.tags,
    {
      "Name" = "${local.name}-private-${count.index}"
    },
  )
}

resource "aws_route" "private_default" {
  count = var.nat_instance ? 0 : var.availability_zones_count

  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.public.*.id, count.index)
}

resource "aws_route" "private_default_instance" {
  count = var.nat_instance ? var.availability_zones_count : 0

  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  instance_id            = element(aws_instance.nat.*.id, count.index)
}

resource "aws_route_table_association" "private" {
  count = var.availability_zones_count

  route_table_id = element(aws_route_table.private.*.id, count.index)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.cloud.id
  tags = merge(
    local.tags,
    {
      "Name" = "${local.name}-public"
    },
  )
}

resource "aws_route" "public_default" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gateway.id
}

resource "aws_route_table_association" "public" {
  count = var.availability_zones_count

  route_table_id = aws_route_table.public.id
  subnet_id      = element(aws_subnet.public.*.id, count.index)
}

data "aws_ami" "ubuntu_1804" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-20190531"]
  }
}

resource "tls_private_key" "bastion" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bastion" {
  key_name   = "${local.name}-bastion"
  public_key = tls_private_key.bastion.public_key_openssh
}

resource "aws_instance" "bastion" {
  count                  = var.availability_zones_count
  ami                    = data.aws_ami.ubuntu_1804.id
  instance_type          = "t3.nano"
  subnet_id              = element(aws_subnet.public.*.id, count.index)
  vpc_security_group_ids = [aws_security_group.bastion.id]
  tags = merge(
    local.tags,
    {
      "Name" = "${local.name}-bastion-${count.index}"
    },
  )
  key_name = aws_key_pair.bastion.key_name
}


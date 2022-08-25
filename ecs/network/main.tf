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

data "aws_region" "current" {
  count = var.create ? 1 : 0
}

locals {
  aws_region = var.create ? data.aws_region.current[0].name : ""
}

data "aws_availability_zones" "zones" {
  count = var.create ? 1 : 0
}

locals {
  az_names = var.create ? slice(data.aws_availability_zones.zones[0].names, 0, 3) : []

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
  count = var.create ? 1 : 0

  cidr_block = local.vpc_block
  tags       = local.tags

  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
}

resource "aws_internet_gateway" "gateway" {
  count = var.create ? 1 : 0

  vpc_id = aws_vpc.cloud[0].id
  tags   = local.tags
}

resource "aws_subnet" "private" {
  count = var.create ? var.availability_zones_count : 0

  vpc_id                  = aws_vpc.cloud[0].id
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
  count = var.create ? max(2, var.availability_zones_count) : 0

  vpc_id                  = aws_vpc.cloud[0].id
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
  count      = var.create ? var.availability_zones_count : 0
  depends_on = [aws_internet_gateway.gateway[0]]

  vpc = true
  tags = merge(
    local.tags,
    {
      "Name" = "${local.name}-public-${count.index}"
    },
  )
}

resource "aws_nat_gateway" "public" {
  count = var.create && !var.nat_instance ? var.availability_zones_count : 0

  allocation_id = element(aws_eip.public_nat[*].id, count.index)
  subnet_id     = element(aws_subnet.public[*].id, count.index)
  tags = merge(
    local.tags,
    {
      "Name" = "${local.name}-public-${count.index}"
    },
  )
}

data "aws_ami" "nat" {
  count = var.create ? 1 : 0

  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = [var.nat_instance_ami_name]
  }
}

resource "aws_instance" "nat" {
  count = var.create && var.nat_instance ? var.availability_zones_count : 0

  ami                    = data.aws_ami.nat[0].id
  instance_type          = var.nat_instance_type
  subnet_id              = element(aws_subnet.public[*].id, count.index)
  vpc_security_group_ids = [aws_security_group.nat[0].id]
  tags = merge(
    local.tags,
    {
      "Name" = "${local.name}-nat-${count.index}"
    },
  )
  source_dest_check = false

  lifecycle {
    create_before_destroy = true
  }

  provisioner "local-exec" {
    # Wait for a new NAT instance to be ready before switching to it
    command = "aws ec2 wait instance-status-ok --region '${local.aws_region}' --instance-ids '${self.id}'"
  }
}

resource "aws_eip_association" "public_nat" {
  count = var.create && var.nat_instance ? var.availability_zones_count : 0

  instance_id   = aws_instance.nat[count.index].id
  allocation_id = aws_eip.public_nat[count.index].id

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "nat" {
  count = var.create && var.nat_instance ? 1 : 0

  name   = "${local.name}-nat"
  vpc_id = aws_vpc.cloud[0].id

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
  count = var.create ? 1 : 0

  name   = "${local.name}-lb"
  vpc_id = aws_vpc.cloud[0].id

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
  count = var.create ? 1 : 0

  name               = local.name
  load_balancer_type = "application"
  subnets            = aws_subnet.public[*].id
  security_groups    = [aws_security_group.lb[0].id]
  tags               = local.tags
}

resource "aws_lb_listener" "http" {
  count = var.create ? 1 : 0

  load_balancer_arn = aws_lb.lb[0].arn
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
  count = var.create ? 1 : 0

  algorithm = "RSA"
}

resource "tls_self_signed_cert" "lb_default" {
  count = var.create ? 1 : 0

  key_algorithm         = "RSA"
  private_key_pem       = tls_private_key.lb_default[0].private_key_pem
  validity_period_hours = 365 * 24

  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
  ]

  subject {
    common_name = aws_lb.lb[0].dns_name
  }
}

resource "aws_acm_certificate" "lb_default" {
  count = var.create ? 1 : 0

  private_key      = tls_private_key.lb_default[0].private_key_pem
  certificate_body = tls_self_signed_cert.lb_default[0].cert_pem
}

resource "aws_lb_listener" "https" {
  count = var.create ? 1 : 0

  load_balancer_arn = aws_lb.lb[0].arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.lb_ssl_policy
  certificate_arn   = aws_acm_certificate.lb_default[0].arn

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "Not Found"
      status_code  = "404"
    }
  }
}

resource "aws_security_group" "hosts" {
  count = var.create ? 1 : 0

  name   = "${local.name}-hosts"
  vpc_id = aws_vpc.cloud[0].id

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.lb[0].id]
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
  count = var.create ? var.availability_zones_count : 0

  vpc_id = aws_vpc.cloud[0].id
  tags = merge(
    local.tags,
    {
      "Name" = "${local.name}-private-${count.index}"
    },
  )
}

resource "aws_route" "private_default" {
  count = var.create && !var.nat_instance ? var.availability_zones_count : 0

  route_table_id         = element(aws_route_table.private[*].id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.public[*].id, count.index)
}

resource "aws_route" "private_default_instance" {
  count = var.create && var.nat_instance ? var.availability_zones_count : 0

  route_table_id         = element(aws_route_table.private[*].id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  instance_id            = element(aws_instance.nat[*].id, count.index)
}

resource "null_resource" "ssm_restart_after_nat_change" {
  count = var.create && var.nat_instance ? var.availability_zones_count : 0

  triggers = {
    instance_id = aws_route.private_default_instance[count.index].instance_id
  }

  provisioner "local-exec" {
    # Workaround for https://github.com/aws/amazon-ssm-agent/issues/266
    # Restart SSM agents of instances within the private subnet
    command = <<EOT
      set -e
      export AWS_DEFAULT_REGION=${local.aws_region}
      subnet_id=${aws_subnet.private[count.index].id}

      echo "Fetching running EC2 instance ids in subnet $subnet_id"
      instance_ids=$(
        aws ec2 describe-instances \
        --filters \
          Name=subnet-id,Values=$subnet_id \
          Name=instance-state-name,Values=running \
        --output text \
        --query 'Reservations[].Instances[].InstanceId' \
      )

      for instance_id in $instance_ids; do
        echo "Restarting SSM agent on $instance_id"
        aws ssm send-command \
          --comment "restart SSM agent after NAT instance change" \
          --document-name AWS-RunShellScript \
          --parameters commands="systemctl restart amazon-ssm-agent.service" \
          --instance-ids $instance_id \
          --output text \
          || true
      done
    EOT
  }
}

resource "aws_route_table_association" "private" {
  count = var.create ? var.availability_zones_count : 0

  route_table_id = element(aws_route_table.private[*].id, count.index)
  subnet_id      = element(aws_subnet.private[*].id, count.index)
}

resource "aws_route_table" "public" {
  count = var.create ? 1 : 0

  vpc_id = aws_vpc.cloud[0].id
  tags = merge(
    local.tags,
    {
      "Name" = "${local.name}-public"
    },
  )
}

resource "aws_route" "public_default" {
  count = var.create ? 1 : 0

  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gateway[0].id
}

resource "aws_route_table_association" "public" {
  count = var.create ? var.availability_zones_count : 0

  route_table_id = aws_route_table.public[0].id
  subnet_id      = element(aws_subnet.public[*].id, count.index)
}

# Bastion hosts remains, that we can't remove because of weird destroy cycle issues
resource "aws_security_group" "bastion" {
  count = var.create ? 1 : 0

  name   = "${local.name}-bastions"
  vpc_id = aws_vpc.cloud[0].id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/32"]
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

resource "tls_private_key" "bastion" {
  count = var.create ? 1 : 0

  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "bastion" {
  count = var.create ? 1 : 0

  key_name   = "${local.name}-bastion"
  public_key = tls_private_key.bastion[0].public_key_openssh
}

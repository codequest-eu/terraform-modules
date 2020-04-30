output "vpc_id" {
  value       = var.create ? aws_vpc.cloud[0].id : null
  description = "The ID of the VPC"
}

output "vpc_block" {
  value       = var.create ? aws_vpc.cloud[0].cidr_block : null
  description = "The CIDR block of the VPC"
}

output "internet_gateway_id" {
  value       = var.create ? aws_internet_gateway.gateway[0].id : null
  description = "The ID of the Internet Gateway"
}

output "private_subnet_ids" {
  value       = var.create ? aws_subnet.private[*].id : null
  description = "The IDs of private subnets"
}

output "private_blocks" {
  value       = var.create ? aws_subnet.private[*].cidr_block : null
  description = "The CIDR blocks of private subnets"
}

output "public_subnet_ids" {
  value       = var.create ? aws_subnet.public[*].id : null
  description = "The IDs of public subnets"
}

output "public_blocks" {
  value       = var.create ? aws_subnet.public[*].cidr_block : null
  description = "The CIDR blocks of public subnets"
}

output "public_gateway_ips" {
  value       = var.create ? aws_nat_gateway.public[*].public_ip : null
  description = "The public IP addresses of nat gateways used for outbound traffic"
}

output "availability_zones" {
  value       = var.create ? aws_subnet.private[*].availability_zone : null
  description = "The availability zones in which corresponding public and private subnets were created"
}

output "load_balancer_id" {
  value       = var.create ? aws_lb.lb[0].id : null
  description = "The ID of the Application Load Balancer"
}

output "load_balancer_arn" {
  value       = var.create ? aws_lb.lb[0].arn : null
  description = "The ARN of the Application Load Balancer"
}

output "load_balancer_domain" {
  value       = var.create ? aws_lb.lb[0].dns_name : null
  description = "The domain name of the Application Load Balancer"
}

output "load_balancer_zone_id" {
  value       = var.create ? aws_lb.lb[0].zone_id : null
  description = "The canonical hosted zone ID of the Application Load Balancer (to be used in a Route 53 Alias record)"
}

output "load_balancer_security_group_id" {
  value       = var.create ? aws_security_group.lb[0].id : null
  description = "The ID of the Application Load Balancer's Security Group"
}

output "load_balancer_security_group_arn" {
  value       = var.create ? aws_security_group.lb[0].arn : null
  description = "The ARN of the Application Load Balancer's Security Group"
}

output "http_listener_arn" {
  value       = var.create ? aws_lb_listener.http[0].arn : null
  description = "The ARN of the ALB's HTTP Listener"
}

output "https_listener_arn" {
  value       = var.create ? aws_lb_listener.https[0].arn : null
  description = "The ARN of the ALB's HTTPS Listener"
}

output "hosts_security_group_id" {
  value       = var.create ? aws_security_group.hosts[0].id : null
  description = "The ID of the Security Group which should be used by host instances"
}

output "hosts_security_group_arn" {
  value       = var.create ? aws_security_group.hosts[0].arn : null
  description = "The ARN of the Security Group which should be used by host instances"
}

output "lb_metrics" {
  description = "Load balancer related Cloudwatch metrics, see [metrics.tf](./metrics.tf)"
  value       = local.lb_metrics
}

output "lb_widgets" {
  description = "Load balancer related Cloudwatch dashboard widgets, see [widgets.tf](./widgets.tf)"
  value       = local.lb_widgets
}

output "nat_instance_metrics" {
  description = "NAT instance Cloudwatch metrics, see [metrics.tf](./metrics.tf)"
  value       = local.nat_instance_metrics
}

output "nat_instance_widgets" {
  description = "NAT instance Cloudwatch dashboard widgets, see [widgets.tf](./widgets.tf)"
  value       = local.nat_instance_widgets
}

output "nat_gateway_metrics" {
  description = "NAT gateway Cloudwatch metrics, see [metrics.tf](./metrics.tf)"
  value       = local.nat_gateway_metrics
}

output "nat_gateway_widgets" {
  description = "NAT gateway Cloudwatch dashboard widgets, see [widgets.tf](./widgets.tf)"
  value       = local.nat_gateway_widgets
}

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

output "bastions_security_group_id" {
  value       = var.create ? aws_security_group.bastion[0].id : null
  description = "The ID of the Security Group which should be used by bastion instances"
}

output "bastions_security_group_arn" {
  value       = var.create ? aws_security_group.bastion[0].arn : null
  description = "The ARN of the Security Group which should be used by bastion instances"
}

output "bastion_key_name" {
  value       = var.create ? aws_key_pair.bastion[0].key_name : null
  description = "Name of the AWS key pair that can be used to access the bastion"
}

output "bastion_private_key" {
  value       = var.create ? tls_private_key.bastion[0].private_key_pem : null
  description = "Private key which can be used to SSH onto a bastion host"
  sensitive   = true
}

output "bastion_public_key_openssh" {
  value       = var.create ? tls_private_key.bastion[0].public_key_openssh : null
  description = "Public key to add to authorized_keys on machines which should be accessible from the bastion"
}

output "bastion_private_ips" {
  value       = var.create ? aws_instance.bastion[*].private_ip : null
  description = "Private IP addresses of bastion hosts"
}

output "bastion_public_ips" {
  value       = var.create ? aws_instance.bastion[*].public_ip : null
  description = "Public IP addresses of bastion hosts"
}


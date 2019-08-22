output "name" {
  value = "${aws_ecs_cluster.cluster.name}"
}

output "arn" {
  value = "${aws_ecs_cluster.cluster.arn}"
}

# network outputs

output "vpc_id" {
  value       = "${module.network.vpc_id}"
  description = "The ID of the VPC"
}

output "vpc_block" {
  value       = "${module.network.vpc_block}"
  description = "The CIDR block of the VPC"
}

output "internet_gateway_id" {
  value       = "${module.network.internet_gateway_id}"
  description = "The ID of the Internet Gateway"
}

output "private_subnet_ids" {
  value       = "${module.network.private_subnet_ids}"
  description = "The IDs of private subnets"
}

output "private_blocks" {
  value       = "${module.network.private_blocks}"
  description = "The CIDR blocks of private subnets"
}

output "public_subnet_ids" {
  value       = "${module.network.public_subnet_ids}"
  description = "The IDs of public subnets"
}

output "public_blocks" {
  value       = "${module.network.public_blocks}"
  description = "The CIDR blocks of public subnets"
}

output "public_gateway_ips" {
  value       = "${module.network.public_gateway_ips}"
  description = "The public IP addresses of nat gateways used for outbound traffic"
}

output "availability_zones" {
  value       = "${module.network.availability_zones}"
  description = "The availability zones in which corresponding public and private subnets were created"
}

output "load_balancer_id" {
  value       = "${module.network.load_balancer_id}"
  description = "The ID of the Application Load Balancer"
}

output "load_balancer_arn" {
  value       = "${module.network.load_balancer_arn}"
  description = "The ARN of the Application Load Balancer"
}

output "load_balancer_domain" {
  value       = "${module.network.load_balancer_domain}"
  description = "The domain name of the Application Load Balancer"
}

output "load_balancer_zone_id" {
  value       = "${module.network.load_balancer_zone_id}"
  description = "The canonical hosted zone ID of the Application Load Balancer (to be used in a Route 53 Alias record)"
}

output "load_balancer_security_group_id" {
  value       = "${module.network.load_balancer_security_group_id}"
  description = "The ID of the Application Load Balancer's Security Group"
}

output "load_balancer_security_group_arn" {
  value       = "${module.network.load_balancer_security_group_arn}"
  description = "The ARN of the Application Load Balancer's Security Group"
}

output "http_listener_arn" {
  value       = "${module.network.http_listener_arn}"
  description = "The ARN of the ALB's HTTP Listener"
}

output "https_listener_arn" {
  value       = "${module.network.https_listener_arn}"
  description = "The ARN of the ALB's HTTPS Listener"
}

output "hosts_security_group_id" {
  value       = "${module.network.hosts_security_group_id}"
  description = "The ID of the Security Group which should be used by host instances"
}

output "hosts_security_group_arn" {
  value       = "${module.network.hosts_security_group_arn}"
  description = "The ARN of the Security Group which should be used by host instances"
}

output "bastions_security_group_id" {
  value       = "${module.network.bastions_security_group_id}"
  description = "The ID of the Security Group which should be used by bastion instances"
}

output "bastions_security_group_arn" {
  value       = "${module.network.bastions_security_group_arn}"
  description = "The ARN of the Security Group which should be used by bastion instances"
}

output "bastion_key_name" {
  value       = "${module.network.bastion_key_name}"
  description = "Name of the AWS key pair that can be used to access the bastion"
}

output "bastion_private_key" {
  value       = "${module.network.bastion_private_key}"
  description = "Private key which can be used to SSH onto a bastion host"
  sensitive   = true
}

output "bastion_public_key_openssh" {
  value       = "${module.network.bastion_public_key_openssh}"
  description = "Public key to add to authorized_keys on machines which should be accessible from the bastion"
}

output "bastion_private_ips" {
  value       = "${module.network.bastion_private_ips}"
  description = "Private IP addresses of bastion hosts"
}

output "bastion_public_ips" {
  value       = "${module.network.bastion_public_ips}"
  description = "Public IP addresses of bastion hosts"
}

# access outputs

output "host_role_name" {
  value       = "${module.access.host_role_name}"
  description = "ECS host role name"
}

output "host_role_arn" {
  value       = "${module.access.host_role_arn}"
  description = "ECS host role ARN"
}

output "host_profile_name" {
  value       = "${module.access.host_profile_name}"
  description = "ECS host instance profile name"
}

output "host_profile_id" {
  value       = "${module.access.host_profile_id}"
  description = "ECS host instance profile ID"
}

output "host_profile_arn" {
  value       = "${module.access.host_profile_arn}"
  description = "ECS host instance profile ARN"
}

output "web_service_role_name" {
  value       = "${module.access.web_service_role_name}"
  description = "ECS web service task role name"
}

output "web_service_role_arn" {
  value       = "${module.access.web_service_role_arn}"
  description = "ECS web service task role ARN"
}

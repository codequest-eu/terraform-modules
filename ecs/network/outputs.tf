output "vpc_id" {
  value       = "${aws_vpc.cloud.id}"
  description = "The ID of the VPC"
}

output "vpc_block" {
  value       = "${aws_vpc.cloud.cidr_block}"
  description = "The CIDR block of the VPC"
}

output "internet_gateway_id" {
  value       = "${aws_internet_gateway.gateway.id}"
  description = "The ID of the Internet Gateway"
}

output "private_subnet_ids" {
  value       = "${aws_subnet.private.*.id}"
  description = "The IDs of private subnets"
}

output "private_blocks" {
  value       = "${aws_subnet.private.*.cidr_block}"
  description = "The CIDR blocks of private subnets"
}

output "public_subnet_ids" {
  value       = "${aws_subnet.public.*.id}"
  description = "The IDs of public subnets"
}

output "public_blocks" {
  value       = "${aws_subnet.public.*.cidr_block}"
  description = "The CIDR blocks of public subnets"
}

output "public_gateway_ips" {
  value       = "${aws_nat_gateway.public.*.public_ip}"
  description = "The public IP addresses of nat gateways used for outbound traffic"
}

output "availability_zones" {
  value       = "${aws_subnet.private.*.availability_zone}"
  description = "The availability zones in which corresponding public and private subnets were created"
}

output "load_balancer_id" {
  value       = "${aws_lb.lb.id}"
  description = "The ID of the Application Load Balancer"
}

output "load_balancer_arn" {
  value       = "${aws_lb.lb.arn}"
  description = "The ARN of the Application Load Balancer"
}

output "load_balancer_domain" {
  value       = "${aws_lb.lb.dns_name}"
  description = "The domain name of the Application Load Balancer"
}

output "load_balancer_zone_id" {
  value       = "${aws_lb.lb.zone_id}"
  description = "The canonical hosted zone ID of the Application Load Balancer (to be used in a Route 53 Alias record)"
}

output "load_balancer_security_group_id" {
  value       = "${aws_security_group.lb.id}"
  description = "The ID of the Application Load Balancer's Security Group"
}

output "load_balancer_security_group_arn" {
  value       = "${aws_security_group.lb.arn}"
  description = "The ARN of the Application Load Balancer's Security Group"
}

output "workers_security_group_id" {
  value       = "${aws_security_group.workers.id}"
  description = "The ID of the Security Group which should be used by worker instances"
}

output "workers_security_group_arn" {
  value       = "${aws_security_group.workers.arn}"
  description = "The ARN of the Security Group which should be used by worker instances"
}

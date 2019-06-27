output "id" {
  description = "Service id"
  value       = "${aws_ecs_service.service.id}"
}

output "target_group_name" {
  description = "Load balancer target group name"
  value       = "${aws_lb_target_group.service.name}"
}

output "target_group_arn" {
  description = "Load balancer target group ARN"
  value       = "${aws_lb_target_group.service.arn}"
}

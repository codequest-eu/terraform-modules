output "id" {
  value       = "${aws_autoscaling_group.hosts.id}"
  description = "Autoscaling group id"
}

output "arn" {
  value       = "${aws_autoscaling_group.hosts.arn}"
  description = "Autoscaling group ARN"
}

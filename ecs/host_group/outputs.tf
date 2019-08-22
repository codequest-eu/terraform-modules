output "id" {
  value       = "${aws_autoscaling_group.hosts.id}"
  description = "Autoscaling group id"
}

output "arn" {
  value       = "${aws_autoscaling_group.hosts.arn}"
  description = "Autoscaling group ARN"
}

output "instance_ids" {
  value = "${data.aws_instances.hosts.ids}"
}

output "instance_private_ips" {
  value = "${data.aws_instances.hosts.private_ips}"
}

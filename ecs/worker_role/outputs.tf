output "role_name" {
  value       = "${aws_iam_role.worker.name}"
  description = "Worker role name"
}

output "role_arn" {
  value       = "${aws_iam_role.worker.arn}"
  description = "Worker role ARN"
}

output "profile_name" {
  value       = "${aws_iam_instance_profile.worker.name}"
  description = "Worker instance profile name"
}

output "profile_id" {
  value       = "${aws_iam_instance_profile.worker.id}"
  description = "Worker instance profile ID"
}

output "profile_arn" {
  value       = "${aws_iam_instance_profile.worker.arn}"
  description = "Worker instance profile ARN"
}

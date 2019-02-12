output "account_id" {
  description = "AWS project account id"
  value       = "${aws_organizations_account.project.id}"
}

output "account_arn" {
  description = "AWS project account ARN"
  value       = "${aws_organizations_account.project.arn}"
}

output "ci_user_name" {
  description = "Infrastructure CI AWS user"
  value       = "${aws_iam_user.ci.name}"
}

output "ci_user_arn" {
  description = "Infrastructure CI AWS user ARN"
  value       = "${aws_iam_user.ci.arn}"
}

output "ci_access_key_id" {
  description = "AWS access key for infrastructure CI user"
  value       = "${aws_iam_access_key.ci.id}"
}

output "ci_secret_access_key" {
  description = "AWS secret key for infrastructure CI user"
  value       = "${aws_iam_access_key.ci.secret}"
  sensitive   = true
}

output "backend_config" {
  description = "Terraform backend config"
  value       = "${data.template_file.backend_config.rendered}"
}

output "meta_backend_config" {
  description = "Terraform meta backend config"
  value       = "${data.template_file.meta_backend_config.rendered}"
}

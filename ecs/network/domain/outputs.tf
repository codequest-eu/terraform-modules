output "certificate_arn" {
  description = "ACM certificate ARN that was added to the https listener"
  value       = local.certificate_arn
}

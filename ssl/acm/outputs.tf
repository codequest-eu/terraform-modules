output "id" {
  description = "ACM certificate id"
  value       = aws_acm_certificate.cert.id
}

output "arn" {
  description = "ACM certificate ARN"
  value       = aws_acm_certificate.cert.arn
}


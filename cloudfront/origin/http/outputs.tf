output "domain" {
  description = "Domain where the origin is hosted"
  value       = var.domain
}

output "port" {
  description = "Port on which the origin listens for HTTP/HTTPS requests"
  value       = var.port
}

output "path" {
  description = "Path where the origin is hosted"
  value       = var.path
}

output "headers" {
  description = "Additional headers to pass to the origin"
  value       = var.headers
}


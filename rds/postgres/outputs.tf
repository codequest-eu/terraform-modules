output "host" {
  description = "DB host"
  value       = local.host
}

output "port" {
  description = "DB port"
  value       = local.port
}

output "db" {
  description = "DB name"
  value       = local.db
}

output "username" {
  description = "DB master username"
  value       = var.username
}

output "password" {
  description = "DB master password"
  value       = var.password
}

output "url" {
  description = "DB connection url"
  value       = local.db_url
}

output "security_group_id" {
  description = "DB security group id"
  value       = var.create ? aws_security_group.db[0].id : null
}

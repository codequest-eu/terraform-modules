output "host" {
  description = "DB host"
  value       = var.create ? aws_db_instance.db[0].address : null
}

output "port" {
  description = "DB port"
  value       = var.create ? aws_db_instance.db[0].port : null
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
  value       = var.create ? "postgres://${var.username}:${var.password}@${aws_db_instance.db[0].address}:${aws_db_instance.db[0].port}/${local.db}" : null
}

output "security_group_id" {
  description = "DB security group id"
  value       = var.create ? aws_security_group.db[0].id : null
}

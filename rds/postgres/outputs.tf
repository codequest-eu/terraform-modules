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
  value       = local.username
}

output "password" {
  description = "DB master password"
  value       = local.password
}

output "url" {
  description = "DB connection url"
  value       = var.create ? "postgres://${local.username}:${local.password}@${aws_db_instance.db[0].address}:${aws_db_instance.db[0].port}/${local.db}" : null
}


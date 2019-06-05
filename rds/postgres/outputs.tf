output "host" {
  description = "DB host"
  value       = "${aws_db_instance.db.address}"
}

output "port" {
  description = "DB port"
  value       = "${aws_db_instance.db.port}"
}

output "db" {
  description = "DB name"
  value       = "${local.db}"
}

output "username" {
  description = "DB master username"
  value       = "${local.username}"
}

output "password" {
  description = "DB master password"
  value       = "${local.password}"
}

output "url" {
  description = "DB connection url"
  value       = "postgres://${local.username}:${local.password}@${aws_db_instance.db.address}:${aws_db_instance.db.port}/${local.db}"
}

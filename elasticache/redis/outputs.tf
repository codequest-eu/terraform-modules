output "host" {
  description = "First Redis instance host"
  value       = var.create ? aws_elasticache_cluster.cache[0].cache_nodes[0].address : null
}

output "port" {
  description = "Redis port"
  value       = var.port
}

output "url" {
  description = "First Redis instance connection url"
  value       = var.create ? "redis://${aws_elasticache_cluster.cache[0].cache_nodes[0].address}:${var.port}" : null
}

locals {
  hosts = var.create ? aws_elasticache_cluster.cache[0].cache_nodes.*.address : null
}

output "hosts" {
  description = "Redis hosts"
  value       = local.hosts
}

output "urls" {
  description = "Redis connection urls"
  value       = var.create ? formatlist("redis://%s:%s", local.hosts, var.port) : null
}


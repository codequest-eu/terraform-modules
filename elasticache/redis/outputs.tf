output "host" {
  description = "First Redis instance host"
  value       = aws_elasticache_cluster.cache.cache_nodes[0].address
}

output "port" {
  description = "Redis port"
  value       = var.port
}

output "url" {
  description = "First Redis instance connection url"
  value       = "redis://${aws_elasticache_cluster.cache.cache_nodes[0].address}:${var.port}"
}

locals {
  hosts = aws_elasticache_cluster.cache.cache_nodes.*.address
}

output "hosts" {
  description = "Redis hosts"
  value       = local.hosts
}

output "urls" {
  description = "Redis connection urls"
  value       = formatlist("redis://%s:%s", local.hosts, var.port)
}


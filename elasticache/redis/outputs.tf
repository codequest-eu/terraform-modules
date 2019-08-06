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

# HACK: using a template_file to map cache_node list to a list of their addresses
# https://stackoverflow.com/questions/43893295/map-list-of-maps-to-a-list-of-selected-field-values-in-terraform
data "template_file" "hosts" {
  count    = var.instance_count
  template = aws_elasticache_cluster.cache.cache_nodes[count.index]["address"]
}

locals {
  hosts = data.template_file.hosts.*.rendered
}

output "hosts" {
  description = "Redis hosts"
  value       = local.hosts
}

output "urls" {
  description = "Redis connection urls"
  value       = formatlist("redis://%s:%s", local.hosts, var.port)
}


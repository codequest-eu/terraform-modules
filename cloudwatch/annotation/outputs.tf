output "is_band" {
  description = "Whether this is a band annotation"
  value       = local.is_band
}

output "is_horizontal" {
  description = "Whether this is a horizontal annotation"
  value       = local.is_horizontal
}

output "is_vertical" {
  description = "Whether this is a vertical annotation"
  value       = ! local.is_horizontal
}

output "body" {
  description = "Annotation structure used by widget modules"
  value       = local.body
}

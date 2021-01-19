output "output_path" {
  description = "Path where the zip was created"
  value       = var.create ? data.archive_file.archive[0].output_path : local.output_path
}

output "output_size" {
  description = "The size of the output archive file."
  value       = var.create ? data.archive_file.archive[0].output_size : null
}

output "output_sha" {
  description = "The SHA1 checksum of output archive file."
  value       = var.create ? data.archive_file.archive[0].output_sha : null
}

output "output_base64sha256" {
  description = "The base64-encoded SHA256 checksum of output archive file."
  value       = var.create ? data.archive_file.archive[0].output_base64sha256 : null
}

output "output_md5" {
  description = "The MD5 checksum of output archive file."
  value       = var.create ? data.archive_file.archive[0].output_md5 : null
}

output "content_paths" {
  depends_on  = [data.archive_file.archive]
  description = "Paths that are included in the zip, eg. for debugging include/exclude patterns"
  value       = local.content_paths
}

output "content_hash" {
  depends_on  = [data.archive_file.archive]
  description = "Hash of the content used in the default `output_path`"
  value       = local.content_hash
}

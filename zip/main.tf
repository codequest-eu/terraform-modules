locals {
  dir_paths = toset(try(
    keys(var.files),
    var.create ? fileset(var.directory, "**") : []
  ))

  # Generate `excludes` argument for `archive_file` by adding:
  # - all files that don't match `directory_include_patterns`
  # - all files that match `directory_exclude_patterns`
  dir_include_matches = toset(
    var.create && var.directory != null ?
    flatten([for pattern in var.directory_include_patterns : fileset(var.directory, pattern)]) :
    local.dir_paths
  )
  dir_exclude_matches = toset(
    var.create && var.directory != null ?
    flatten([for pattern in var.directory_exclude_patterns : fileset(var.directory, pattern)]) :
    []
  )
  dir_excludes = setunion(
    setsubtract(local.dir_paths, local.dir_include_matches),
    local.dir_exclude_matches,
  )

  content_paths = setsubtract(local.dir_paths, local.dir_excludes)
  content_hash = md5(jsonencode({
    for path in local.content_paths : path => try(
      md5(var.files[path]),
      filemd5("${var.directory}/${path}")
    )
  }))

  output_path = try(
    replace(var.output_path, "{hash}", local.content_hash),
    "${path.module}/tmp/${local.content_hash}.zip"
  )
}

data "archive_file" "archive" {
  count = var.create ? 1 : 0

  type        = "zip"
  output_path = local.output_path

  source_dir = var.directory
  excludes   = local.dir_excludes

  dynamic "source" {
    for_each = var.files != null ? var.files : {}

    content {
      filename = source.key
      content  = source.value
    }
  }
}

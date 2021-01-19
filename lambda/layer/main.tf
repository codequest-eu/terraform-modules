locals {
  package_s3_match = var.package_s3 != null ? regex(
    "(?P<bucket>[^/]+)/(?P<key>.+)", var.package_s3
  ) : { bucket = null, key = null }
  package_s3_bucket = local.package_s3_match.bucket
  package_s3_key    = local.package_s3_match.key
}

module "package" {
  source = "./../../zip"
  create = var.create && (var.files != null || var.files_dir != null)

  files                      = var.files
  directory                  = var.files_dir
  directory_include_patterns = var.file_patterns
  directory_exclude_patterns = var.file_exclude_patterns

  output_path = "${path.module}/tmp/{hash}.zip"
}

resource "aws_lambda_layer_version" "layer" {
  count = var.create ? 1 : 0

  layer_name          = var.name
  compatible_runtimes = var.runtimes

  filename          = coalesce(var.package_path, module.package.output_path)
  s3_bucket         = local.package_s3_bucket
  s3_key            = local.package_s3_key
  s3_object_version = var.package_s3_version
}

locals {
  name          = var.create ? aws_lambda_layer_version.layer[0].layer_name : var.name
  arn           = var.create ? aws_lambda_layer_version.layer[0].layer_arn : ""
  qualified_arn = var.create ? aws_lambda_layer_version.layer[0].arn : ""
  version       = var.create ? aws_lambda_layer_version.layer[0].version : ""
}

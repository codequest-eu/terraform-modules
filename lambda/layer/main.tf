locals {
  create_package = var.create && (var.files != null || var.files_dir != null)
}

module "package" {
  source = "./../../zip"
  create = local.create_package

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

  filename          = local.create_package ? module.package.output_path : var.package_path
  s3_bucket         = var.package_s3 != null ? var.package_s3.bucket : null
  s3_key            = var.package_s3 != null ? var.package_s3.key : null
  s3_object_version = var.package_s3_version
}

locals {
  name          = var.create ? aws_lambda_layer_version.layer[0].layer_name : var.name
  arn           = var.create ? aws_lambda_layer_version.layer[0].layer_arn : ""
  qualified_arn = var.create ? aws_lambda_layer_version.layer[0].arn : ""
  version       = var.create ? aws_lambda_layer_version.layer[0].version : ""
}

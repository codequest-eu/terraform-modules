module "package" {
  source = "./../../zip"
  create = var.create

  files                      = var.files
  directory                  = var.files_dir
  directory_include_patterns = var.file_patterns
  directory_exclude_patterns = var.file_exclude_patterns

  output_path = "${path.module}/tmp/{hash}.zip"
}

resource "aws_lambda_layer_version" "layer" {
  count = var.create ? 1 : 0

  layer_name          = var.name
  filename            = module.package.output_path
  compatible_runtimes = var.runtimes
}

locals {
  name          = var.create ? aws_lambda_layer_version.layer[0].layer_name : var.name
  arn           = var.create ? aws_lambda_layer_version.layer[0].layer_arn : ""
  qualified_arn = var.create ? aws_lambda_layer_version.layer[0].arn : ""
  version       = var.create ? aws_lambda_layer_version.layer[0].version : ""
}

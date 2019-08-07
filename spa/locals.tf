locals {
  name_prefix = "${var.project}-${var.environment}"

  default_tags = {
    Project     = var.project
    Environment = var.environment
  }

  tags = merge(local.default_tags, var.tags)

  urls = formatlist("https://%s", var.domains)
}


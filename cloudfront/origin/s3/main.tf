data "aws_region" "current" {
  count = var.create ? 1 : 0
}

locals {
  domain = (
    var.create ?
    "${var.bucket}.s3.${data.aws_region.current[0].name}.amazonaws.com" :
    ""
  )
}

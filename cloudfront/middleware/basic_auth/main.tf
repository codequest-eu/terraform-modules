module "middleware" {
  source = "./.."
  create = var.create

  name = var.name
  tags = var.tags

  code    = templatefile("${path.module}/index.js", { credentials = var.credentials })
  handler = "index.handler"
  runtime = "nodejs12.x"
}

module "middleware" {
  source = "./.."
  create = var.create

  name = var.name
  tags = var.tags

  code    = templatefile("${path.module}/index.js", { path_re = var.path_re })
  handler = "index.handler"
  runtime = "nodejs12.x"
}

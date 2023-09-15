module "middleware" {
  source = "./.."
  create = var.create

  name         = var.name
  tags         = var.tags
  package_path = var.package_path

  code    = templatefile("${path.module}/index.js", { path_re = var.path_re })
  handler = "index.handler"
  runtime = "nodejs18.x"
}

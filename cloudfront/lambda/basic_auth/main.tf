module "middleware" {
  source = "./.."
  create = var.create

  name = var.name
  tags = var.tags

  code = templatefile("${path.module}/index.js", {
    credentials = base64encode(var.credentials)
  })
  handler = "index.handler"
  runtime = "nodejs12.x"
}

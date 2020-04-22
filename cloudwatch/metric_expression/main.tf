locals {
  vars_hash = md5(jsonencode([
    var.expression,
    var.label,
    var.color,
  ]))

  id = "e_${local.vars_hash}"
}

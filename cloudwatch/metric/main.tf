locals {
  vars_hash = md5(jsonencode([
    var.namespace,
    var.name,
    var.dimensions,
    var.period,
    var.stat,
    var.label,
    var.color,
  ]))

  id = "m_${var.name}_${local.vars_hash}"
}

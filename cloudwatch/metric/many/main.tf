module "default" {
  source = "./.."

  namespace = ""
  name      = ""
}

locals {
  out = [for v in var.vars : {
    id = "m_${v.name}_${md5(jsonencode([
      v.namespace,
      v.name,
      try(v.dimensions, module.default.dimensions),
      try(v.period, module.default.period),
      try(v.stat, module.default.stat),
      try(v.label, module.default.label),
      try(v.color, module.default.color),
    ]))}"

    namespace  = v.namespace
    name       = v.name
    dimensions = try(v.dimensions, module.default.dimensions)
    period     = try(v.period, module.default.period)
    stat       = try(v.stat, module.default.stat)
    label      = try(v.label, module.default.label)
    color      = try(v.color, module.default.color)
  }]

  out_map = { for k, v in var.vars_map : k => {
    id = "m_${v.name}_${md5(jsonencode([
      v.namespace,
      v.name,
      try(v.dimensions, module.default.dimensions),
      try(v.period, module.default.period),
      try(v.stat, module.default.stat),
      try(v.label, module.default.label),
      try(v.color, module.default.color),
    ]))}"

    namespace  = v.namespace
    name       = v.name
    dimensions = try(v.dimensions, module.default.dimensions)
    period     = try(v.period, module.default.period)
    stat       = try(v.stat, module.default.stat)
    label      = try(v.label, module.default.label)
    color      = try(v.color, module.default.color)
  } }
}

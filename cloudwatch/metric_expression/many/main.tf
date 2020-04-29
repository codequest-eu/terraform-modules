module "default" {
  source = "./.."

  expression = ""
}

locals {
  out = [for v in var.vars : {
    id = "e_${md5(jsonencode([
      v.expression,
      try(v.label, module.default.label),
      try(v.color, module.default.color),
    ]))}"

    expression = v.expression
    label      = try(v.label, module.default.label)
    color      = try(v.color, module.default.color)
  }]

  out_map = { for k, v in var.vars_map : k => {
    id = "e_${md5(jsonencode([
      v.expression,
      try(v.label, module.default.label),
      try(v.color, module.default.color),
    ]))}"

    expression = v.expression
    label      = try(v.label, module.default.label)
    color      = try(v.color, module.default.color)
  } }
}

locals {
  is_band       = var.value_range != null || var.time_range != null
  is_horizontal = var.value != null || var.value_range != null

  labels = local.is_band ? var.labels : [var.label, null]

  # HACK: workaround for ternary causing numbers to be cast to strings
  value_vars = merge(
    var.value != null ? { value = var.value } : {},
    var.value_range != null ? { value_range = var.value_range } : {},
    var.time != null ? { time = var.time } : {},
    var.time_range != null ? { time_range = var.time_range } : {},
  )
  values = try(
    [local.value_vars.value, null],
    [local.value_vars.time, null],
    local.value_vars.value_range,
    local.value_vars.time_range,
  )

  annotations = concat(
    [merge(
      {
        value = local.values[0]
        label = local.labels[0]
        color = var.color
      },
      local.is_band ? {} : { fill = var.fill },
    )],
    local.is_band ? [{
      value = local.values[1]
      label = local.labels[1]
    }] : [],
  )

  # HACK: terraform ternary values have to have the same type :(
  body = jsondecode(
    local.is_band ?
    jsonencode(local.annotations) :
    jsonencode(local.annotations[0])
  )
}

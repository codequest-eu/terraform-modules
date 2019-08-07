module "one" {
  source = "./.."
  length = 16
}

output "one" {
  value = module.one.result
}

module "many_copies" {
  source    = "./../many"
  variables = [for i in range(3) : { length = 8 }]
}

output "many_copies" {
  value = module.many_copies.outputs[*].result
}

module "many_different" {
  source = "./../many"
  variables = [
    { length = 8 },
    { length = 12 },
    { length = 16 }
  ]
}

output "many_different" {
  value = module.many_different.outputs[*].result
}

module "none" {
  source    = "./../many"
  variables = []
}

output "none" {
  value = module.none.outputs[*].result
}

output "all" {
  value = concat(
    [module.one.result],
    module.many_copies.outputs[*].result,
    module.many_different.outputs[*].result,
    module.none.outputs[*].result
  )
}

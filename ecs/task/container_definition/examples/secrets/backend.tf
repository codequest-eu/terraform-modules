terraform {
  backend "s3" {
    key = "ecs/task/container_definition/examples/secrets"
  }
}

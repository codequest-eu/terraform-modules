# Terraform modules

Terraform modules commonly used by our projects

## Terraform version

**Modules within this repository require terraform 0.12.x**.
If you're on 0.11.x use the [`terraform-0.11`](https://github.com/codequest-eu/terraform-modules/tree/terraform-0.11) branch, which is not actively developed anymore.

## Modules

- [`ecs`](./ecs)

  Creates an ECS cluster, contains submodules for creating additional resources within the cluster.

- [`meta`](./meta)

  Creates infrastructure for terraform itself and infrastructure CI/CD

- [ssl/acm](./ssl/acm)

  Creates an SSL certificate using AWS ACM

## External modules

- [terraform-single-page-app](https://github.com/codequest-eu/terraform-single-page-app)

  Common infrastructure for Single Page Applications

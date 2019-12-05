# Terraform modules

Terraform modules commonly used by our projects

## Terraform version

**Modules within this repository require terraform 0.12.x**.
If you're on 0.11.x use the [`terraform-0.11`](https://github.com/codequest-eu/terraform-modules/tree/terraform-0.11) branch, which is not actively developed anymore.

## Modules

- [`ecs`](./ecs)

  Creates an ECS cluster, contains submodules for creating additional resources within the cluster.

- [`elasticache/redis`](./elasticache/redis)

  Creates a Redis cluster using AWS ElastiCache

- [`meta`](./meta)

  Creates infrastructure for terraform itself and infrastructure CI/CD

- [`rds/postgres`](./rds/postgres)

  Creates a PostgreSQL database using AWS RDS

- [`spa`](./spa)

  Creates common infrastructure for single page applications

- [`ssl/acm`](./ssl/acm)

  Creates an SSL certificate using AWS ACM

- [`iam/user_with_policies`](./iam/user_with_policies)

  Creates an AWS IAM user with an access key and attaches policies to it

- [`ses/domain`](./ses/domain)

  Registers a domain with AWS SES and verifies it

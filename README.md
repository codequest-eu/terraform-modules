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

- [`iam/user`](./iam/user)

  Creates an AWS IAM user with an access key

- [`ses/domain`](./ses/domain)

  Registers a domain with AWS SES and verifies it

## Local setup

To run examples you will need to prepare:

1. Docker and docker-compose
1. An AWS account with an Administrator IAM user
1. Access key to authenticate as the Administrator
1. (optional) Example working hosted zone to add DNS records to

   Some examples require a hosted zone to setup DNS records, e.g. to validate TLS certificates or route traffic to services.

Once these are ready:

1. Copy `.env.template` to `.env` and fill in the blanks in `.env`

   1. `AWS_PROFILE` can be left empty if you want to use your default AWS CLI profile
   2. `TF_VAR_zone_domain` should contain the example hosted zone domain, e.g. `terraform-examples.com`

2. Build the container with development tools

   ```sh
   docker-compose build
   ```

3. Run the development shell

   ```sh
   docker-compose run --rm shell bash
   ```

4. Go to one of the examples and `terraform apply`, e.g.

   ```sh
   cd iam/user/example
   terraform init
   terraform apply
   ```

5. Destroy the example once you no longer need it

   ```sh
   cd iam/user/example
   terraform destroy
   ```

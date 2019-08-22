provider "aws" {
  region = "eu-west-1"
}


data "aws_vpc" "default" {
  default = true
}

data "aws_availability_zones" "all" {
}

data "aws_subnet" "a" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = data.aws_availability_zones.all.names[0]
  default_for_az    = true
}

data "aws_subnet" "b" {
  vpc_id            = data.aws_vpc.default.id
  availability_zone = data.aws_availability_zones.all.names[1]
  default_for_az    = true
}

module "redis" {
  source = "./.."

  id          = "tfm-redis-example"
  project     = "terraform-modules-redis"
  environment = "example"

  vpc_id     = data.aws_vpc.default.id
  subnet_ids = [data.aws_subnet.a.id]

  instance_type  = "cache.t2.micro"
  instance_count = 1
}

output "redis_url" {
  value     = module.redis.url
  sensitive = true
}

output "redis_urls" {
  value     = module.redis.urls
  sensitive = true
}


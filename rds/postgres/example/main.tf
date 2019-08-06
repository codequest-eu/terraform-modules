provider "aws" {
  version = "~> 2.22.0"

  region = "eu-west-1"
}

provider "random" {
  version = "~> 2.1.2"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_availability_zones" "all" {}

data "aws_subnet" "a" {
  vpc_id            = "${data.aws_vpc.default.id}"
  availability_zone = "${data.aws_availability_zones.all.names[0]}"
  default_for_az    = true
}

data "aws_subnet" "b" {
  vpc_id            = "${data.aws_vpc.default.id}"
  availability_zone = "${data.aws_availability_zones.all.names[1]}"
  default_for_az    = true
}

module "db" {
  source = ".."

  project     = "terraform-modules-postgres"
  environment = "example"

  vpc_id     = "${data.aws_vpc.default.id}"
  subnet_ids = ["${data.aws_subnet.a.id}", "${data.aws_subnet.b.id}"]
  multi_az   = false

  instance_type = "db.t2.micro"
  storage       = 20
  public        = true

  prevent_destroy = false
}

output "db_url" {
  value     = "${module.db.url}"
  sensitive = true
}

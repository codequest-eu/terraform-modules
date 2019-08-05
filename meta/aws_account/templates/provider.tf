provider "aws" {
  region              = "${region}"
  allowed_account_ids = ["${id}"]

  assume_role {
    role_arn = "${role_arn}"
  }
}

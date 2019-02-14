provider "aws" {
  region              = "${region}"
  allowed_account_ids = ["${id}"]

  # Uncomment if you're using root account user credentials to manage project resources
  # assume_role         = "${role_arn}"
}

provider "aws" {
  region              = "${region}"
  allowed_account_ids = ["${account_id}"]

  # Uncomment if you're using root account user credentials to manage project resources
  # assume_role         = "${account_role_arn}"
}

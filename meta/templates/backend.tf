terraform {
  backend "s3" {
    bucket         = "${bucket}"
    key            = "${key}"
    dynamodb_table = "${lock_table}"
    region         = "${region}"
    encrypt        = true

    # Uncomment if you're using root account user credentials to manage project resources
    # role_arn       = "${account_role_arn}"
  }
}

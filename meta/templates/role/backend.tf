terraform {
  backend "s3" {
    bucket         = "${bucket}"
    key            = "${key}"
    dynamodb_table = "${lock_table}"
    region         = "${region}"
    encrypt        = true
    role_arn       = "${account_role_arn}"
  }
}

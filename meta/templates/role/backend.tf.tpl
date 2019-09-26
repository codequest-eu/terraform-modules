terraform {
  backend "s3" {
    bucket         = "${bucket}"
    key            = "${key}"
    dynamodb_table = "${dynamodb_table}"
    region         = "${region}"
    encrypt        = ${jsonencode(encrypt)}
    role_arn       = "${role_arn}"
  }
}

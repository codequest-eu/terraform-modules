terraform {
  backend "s3" {
    bucket         = "${bucket}"
    key            = "${key}"
    dynamodb_table = "${lock_table}"
    region         = "${region}"
    encrypt        = true
  }
}

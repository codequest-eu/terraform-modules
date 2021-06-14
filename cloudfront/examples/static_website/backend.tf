terraform {
  backend "s3" {
    key = "cloudfront/examples/static_website"
  }
}

terraform {
  backend "s3" {
    key = "{{ path }}"
  }
}

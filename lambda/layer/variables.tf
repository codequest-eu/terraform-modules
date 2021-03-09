variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}

variable "name" {
  description = "Lambda layer name"
  type        = string
}

variable "runtimes" {
  description = "[Runtimes](https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html#SSS-CreateFunction-request-Runtime) compatible with this lambda layer"
  type        = list(string)
  default     = ["nodejs12.x"]
}

variable "package_path" {
  description = "Path to the zip that contains the Lambda layer's source. Either `package_path`, `package_s3` or `image` is required."
  type        = string
  default     = null
}

variable "package_s3" {
  description = "S3 zip object that contains the Lambda layer's source. Either `package_path` or `package_s3` is required."
  type = object({
    bucket = string
    key    = string
  })
  default = null
}

variable "package_s3_version" {
  description = "Version number of the S3 object to use"
  type        = string
  default     = null
}

variable "files" {
  description = <<EOT
**Deprecated. Use the `zip` module and `package_path` input instead.**

    Source code map. Either `files` or `files_dir` has to be specified
  EOT

  type    = map(string)
  default = null
}

variable "files_dir" {
  description = <<EOT
**Deprecated. Use the `zip` module and `package_path` input instead.**

    Source code directory path. Either `files` or `files_dir` has to be specified
  EOT

  type    = string
  default = null
}

variable "file_patterns" {
  description = <<EOT
**Deprecated. Use the `zip` module and `package_path` input instead.**

    Source code file path patterns to narrow `files_dir` contents.
  EOT

  type    = list(string)
  default = ["**"]
}

variable "file_exclude_patterns" {
  description = <<EOT
**Deprecated. Use the `zip` module and `package_path` input instead.**

    Source code file exclusion patterns in case some unnecessary files are matched by `file_paths`.
  EOT

  type    = list(string)
  default = []
}


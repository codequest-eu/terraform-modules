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

variable "files" {
  description = "Source code map. Either `files` or `files_dir` has to be specified"
  type        = map(string)
  default     = null
}

variable "files_dir" {
  description = "Source code directory path. Either `files` or `files_dir` has to be specified"
  type        = string
  default     = null
}

variable "file_patterns" {
  description = "Source code file path patterns to narrow `files_dir` contents."
  type        = list(string)
  default     = ["**"]
}

variable "file_exclude_patterns" {
  description = "Source code file exclusion patterns in case some unnecessary files are matched by `file_paths`."
  type        = list(string)
  default     = []
}


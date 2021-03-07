variable "create" {
  description = "Whether any resources should be created"
  type        = bool
  default     = true
}

variable "output_path" {
  description = "Path where the zip should be created, defaults to `{zip module path}/tmp/{hash}.zip`, any instances of `{hash}` will be replaced with the archive content hash."
  type        = string
  default     = null
}

variable "files" {
  description = "Source code map. Either `files` or `directory` has to be specified"
  type        = map(string)
  default     = null
}

variable "directory" {
  description = "Source code directory path. Either `files` or `directory` has to be specified"
  type        = string
  default     = null
}

variable "directory_include_patterns" {
  description = "Source code file path patterns to narrow `directory` contents."
  type        = list(string)
  default     = ["**"]
}

variable "directory_exclude_patterns" {
  description = "Source code file exclusion patterns in case some unnecessary files are matched by `directory_include_patterns`."
  type        = list(string)
  default     = []
}

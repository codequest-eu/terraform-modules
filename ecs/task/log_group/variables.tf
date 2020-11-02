variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}

variable "project" {
  description = "Kebab-cased project name"
  type        = string
}

variable "environment" {
  description = "Kebab-cased environment name, eg. development, staging, production."
  type        = string
}

variable "tags" {
  description = "Tags to add to resources that support them"
  type        = map(string)
  default     = {}
}

variable "task" {
  description = "ECS task definition name"
  type        = string
}

variable "container" {
  description = "Container name within the task definition"
  type        = string
  default     = ""
}

variable "retention" {
  description = <<EOF
    Log retention in days.

    Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1827, 3653, and 0.
    If you select 0, the events in the log group are always retained and never expire."
  EOF

  type    = number
  default = 7
}

variable "create" {
  description = "Should resources be created"
  default     = true
  type        = bool
}

variable "tags" {
  description = "Tags to add to resources that support them"
  type        = map(string)
  default     = {}
}

variable "name" {
  description = "Lambda name"
  type        = string
}

variable "db_url" {
  description = "Database URL with master credentials"
  type        = string
}

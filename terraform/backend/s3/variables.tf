variable "create" {
  description = "Whether any resources should be created"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to add to resources"
  type        = map(string)
  default     = {}
}

variable "bucket_name" {
  description = "State bucket name"
  type        = string
}

variable "lock_table_name" {
  description = "DynamoDB lock table name, defaults to `{bucket}-lock`"
  type        = string
  default     = null
}

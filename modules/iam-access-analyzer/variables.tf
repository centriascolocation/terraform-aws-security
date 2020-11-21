variable "enabled" {
  description = "Set to false will not create an Analyzer"
  default     = true
  type        = bool
}

variable "analyzer_name" {
  description = "Name for the IAM Access Analyzer"
  default     = "default-analyzer"
  type        = string
}

variable "is_organization" {
  description = "Set this to true if the IAM Access Analyzer should be enabled in an Organization Master Account"
  default     = false
  type        = bool
}

variable "tags" {
  description = "Add these tags to all resources created by this module"
  default = {
    Generator = "Terraform"
  }
}

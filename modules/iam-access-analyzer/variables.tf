variable "enabled" {
  description = "Set to false will not create an Analyzer"
  default     = true
}

variable "analyzer_name" {
  description = "Name for the IAM Access Analyzer"
  default     = "default-analyzer"
}

variable "is_organization" {
  description = "Set this to true if the IAM Access Analyzer should be enabled in an Organization Master Account"
  default     = false
}

variable "tags" {
  description = "Add these tags to all resources created by this module"
  default = {
    "Terraform" = true
  }
}

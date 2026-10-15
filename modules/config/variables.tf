variable "recorder_role_arn" {
  description = "Recorder role override. The legacy custom role remains managed to avoid deleting it during migration."
  type        = string
  default     = null
}

variable "config_name" {
  description = "The name for the corresponding config resources"
  default     = ""
  type        = string
}
variable "config_bucket_name_prefix" {
  description = "Prefix name for config bucket"
  default     = "config-"
  type        = string
}
variable "common_tags" {
  description = "values for additional tags"
  default = {
    Generator = "Terraform"
    Module    = "aws.terraform.modules.config"
  }
  type = map(string)
}
variable "config_bucket_key_prefix" {
  description = "Prefix name for config objects in bucket"
  default     = "config"
  type        = string
}
variable "config_delivery_frequency" {
  description = "The frequency with which AWS Config delivers configuration snapshots."
  default     = "Six_Hours"
  type        = string
}
variable "aws_account_id" {
  description = "corresponding number of aws account"
  default     = ""
  type        = string
}

variable "record_all_supported_resources" {
  description = "Record all supported resource types; false selects resource_types."
  type        = bool
  default     = true
}

variable "resource_types" {
  description = "Explicit resource types when record_all_supported_resources is false."
  type        = set(string)
  default     = []
}

variable "include_global_resource_types" {
  description = "Include global IAM resources; enable in only one supported Region per account."
  type        = bool
  default     = true
}

variable "recording_frequency" {
  description = "Configuration recording frequency, independent of snapshot delivery."
  type        = string
  default     = "CONTINUOUS"
  validation {
    condition     = contains(["CONTINUOUS", "DAILY"], var.recording_frequency)
    error_message = "Choose CONTINUOUS or DAILY; AWS restrictions for daily recording still apply."
  }
}

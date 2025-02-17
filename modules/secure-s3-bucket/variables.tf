variable "bucket_name" {
  description = "The name of the S3 bucket (3 - 63 characters long)"
  type        = string
}

variable "log_bucket_name" {
  description = "The name of the S3 Logging bucket (3 - 63 characters long)"
  type        = string
  default     = ""
}

variable "logging" {
  description = "Bucket Access Logging configuration. (map)"
  type        = map(string)
  default     = {}
}

variable "force_destroy" {
  description = "A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  default     = false
  type        = bool
}

variable "enabled" {
  description = "A boolean that indicates this module is enabled. Resources are not created if it is set to false."
  default     = true
  type        = bool
}

variable "tags" {
  description = "Add these tags to all resources created by this module"
  default = {
    Generator = "Terraform"
  }
  type = map(any)
}

variable "enable_versioning" {
  description = "Whether to enable versioning for the bucket"
  default     = true
  type        = bool
}

variable "mfa_delete" {
  description = "Forces deletion of object to identities with mfa auth. Only the bucket owner (root account) can enable MFA delete"
  default     = false
  type        = bool
}

variable "lifecycle_rule_current_version" {
  description = "change storage class after days for current objects"
  type        = map(string)
  default = {
    days          = 90
    storage_class = "GLACIER"
  }
}

variable "lifecycle_rule_noncurrent_version" {
  description = "change storage class after days for non-current objects (older versions)"
  type        = map(string)
  default = {
    days          = 90
    storage_class = "GLACIER"
  }
}

variable "lifecycle_rule_expiration" {
  description = "Specifies a period in the object's expire"
  type        = map(string)
  default = {
    date                         = null
    days                         = null
    expired_object_delete_marker = null
  }
}

variable "transition_default_minimum_object_size" {
  description = "The default minimum object size behavior for S3 lifecycle transition. Allowed values: all_storage_classes_128K, varies_by_storage_class."
  type        = string
  default     = "all_storage_classes_128K"

  validation {
    condition     = contains(["all_storage_classes_128K", "varies_by_storage_class"], var.transition_default_minimum_object_size)
    error_message = "transition_default_minimum_object_size must be either 'all_storage_classes_128K' or 'varies_by_storage_class'."
  }
}

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

variable "lifecycle_glacier_transition_days" {
  description = "The number of days after object creation when the object is archived into Glacier."
  default     = 90
  type        = number
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

variable "mfa_delete" {
  description = "Forces deletion of object to identities with mfa auth. Only the bucket owner (root account) can enable MFA delete"
  default     = false
  type        = bool
}

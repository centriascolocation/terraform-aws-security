
variable "trail_name" {
  description = "The name of the Trail"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket (3 - 63 characters long)"
  type        = string
}

variable "is_organization_trail" {
  description = "Whether this is an Organizational Trail"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Add these tags to all resources created by this module"
  default = {
    Generator = "Terraform"
  }
  type = map
}

variable "cloudtrail_depends_on" {
  description = "External resources which should be set up before CloudTrail, e.g. the Secure S3 Bucket"
  default     = []
  type        = list
}

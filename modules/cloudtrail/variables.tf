
variable "kms_key_id" {
  description = "Optional KMS key ARN for CloudTrail log encryption."
  type        = string
  default     = null
}
variable "cloud_watch_logs_group_arn" {
  description = "Optional CloudWatch Logs group ARN with a trailing :*."
  type        = string
  default     = null
}
variable "cloud_watch_logs_role_arn" {
  description = "Optional IAM role ARN for CloudWatch Logs delivery."
  type        = string
  default     = null
}

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
  type = map(any)
}

variable "cloudtrail_depends_on" {
  description = "External resources which should be set up before CloudTrail, e.g. the Secure S3 Bucket"
  default     = []
  type        = list(any)
}

variable "manage_bucket_policy" {
  description = "Manage the complete TLS and CloudTrail delivery policy. If false, install bucket_policy_json externally before creating the trail."
  type        = bool
  default     = true
}

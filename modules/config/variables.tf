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
